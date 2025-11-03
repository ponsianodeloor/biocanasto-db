// Script para mongosh/DataGrip: insertar un documento en la colección `filesUpload`.
// Revisa y ejecuta este archivo desde la consola conectada a la BD correcta.

const COLLECTION_NAME = 'filesUpload';
const FORCE = false; // Si true, inserta aunque exista un documento igual (por nombre+fecha_subida)

// Documento a insertar
const docToInsert = {
  nombre: 'Archivo de ejemplo',
  tipo: 'txt',
  tamano: 1024,
  fecha_subida: new Date('2025-10-30T05:26:15.699+00:00')
};

(function insertDoc() {
  if (typeof db === 'undefined') {
    print('Error: objeto `db` no encontrado. Ejecuta este script desde mongosh/DataGrip conectado a la BD.');
    return;
  }

  const col = db.getCollection(COLLECTION_NAME);
  print(`Colección: ${COLLECTION_NAME}`);
  print('Documento a insertar:');
  printjson(docToInsert);

  // Comprobación de duplicados simples por nombre + fecha_subida
  const existing = col.findOne({ nombre: docToInsert.nombre, fecha_subida: docToInsert.fecha_subida });
  if (existing && !FORCE) {
    print('\nExiste un documento con el mismo nombre y fecha_subida. Operación cancelada.');
    print('Documento existente (muestra):');
    printjson(existing);
    print('\nSi quieres forzar la inserción, edita la constante FORCE = true en este archivo y vuelve a ejecutar.');
    return;
  }

  const res = col.insertOne(docToInsert);
  print('\nInserción realizada:');
  printjson(res);
})();

