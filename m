Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC0CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 07:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86FF9402B6;
	Thu,  4 Jun 2026 09:46:50 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 62AC8402D3
 for <dev@dpdk.org>; Thu,  4 Jun 2026 09:46:49 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 504624B5C8; Thu,  4 Jun 2026 09:46:49 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1952] hash: build fails with LTO
Date: Thu, 04 Jun 2026 07:46:48 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david.marchand@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: bruce.richardson@intel.com
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1952-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

http://bugs.dpdk.org/show_bug.cgi?id=3D1952

            Bug ID: 1952
           Summary: hash: build fails with LTO
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: bruce.richardson@intel.com
          Reporter: david.marchand@redhat.com
                CC: dev@dpdk.org, konstantin.v.ananyev@yandex.ru,
                    ktraynor@redhat.com, vladimir.medvedkin@intel.com
  Target Milestone: ---

It is similar to a previous report, that resulting in silencing associated
warnings in dea4c5415506 ("ring: silence GCC 12 warnings").

For now, I associate the issue to the hash library, though the problem may =
be
on the ring library side.


Minimal reproducer:

# rm -rf build; meson setup build -Db_lto=3Dtrue -Dcpu_instruction_set=3Dge=
neric
-Doptimization=3D0 -Ddisable_libs=3D* -Denable_apps=3Dtest-pmd
-Denable_drivers=3Dnet/null -Ddeveloper_mode=3Ddisabled && ninja -C build
...
The Meson build system
Version: 1.7.2
...
Project version: 26.07.0-rc0
C compiler for the host machine: ccache cc (gcc 15.2.1 "cc (GCC) 15.2.1
20260123 (Red Hat 15.2.1-7)")
C linker for the host machine: cc ld.bfd 2.44-12
...
Found pkg-config: YES (/usr/bin/pkg-config) 2.3.0
...
Compiler for C supports arguments -ffat-lto-objects: YES=20
...
Found ninja-1.12.1 at /usr/bin/ninja
ninja: Entering directory `build'=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
[280/284] Linking target lib/librte_hash.so.26.2
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_create=E2=80=99 at ../lib/hash/rte_cucko=
o_hash.c:375:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_create=E2=80=
=99:
../lib/hash/rte_cuckoo_hash.c:184:18: note: source object =E2=80=98i=E2=80=
=99 of size 4
  184 |         uint32_t i;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_create=E2=80=99 at ../lib/hash/rte_cucko=
o_hash.c:524:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_create=E2=80=
=99:
../lib/hash/rte_cuckoo_hash.c:184:18: note: source object =E2=80=98i=E2=80=
=99 of size 4
  184 |         uint32_t i;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_reset=E2=80=99 at ../lib/hash/rte_cuckoo=
_hash.c:730:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_reset=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:693:32: note: source object =E2=80=98i=E2=80=
=99 of size 4
  693 |         uint32_t tot_ring_cnt, i;
      |                                ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_reset=E2=80=99 at ../lib/hash/rte_cuckoo=
_hash.c:735:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_reset=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:693:32: note: source object =E2=80=98i=E2=80=
=99 of size 4
  693 |         uint32_t tot_ring_cnt, i;
      |                                ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98enqueue_slot_back=E2=80=99 at ../lib/hash/rte_cuc=
koo_hash.c:761:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98enqueue_slot_back=E2=80=
=99:
../lib/hash/rte_cuckoo_hash.c:755:26: note: source object =E2=80=98slot_id=
=E2=80=99 of size 4
  755 |                 uint32_t slot_id)
      |                          ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98__rte_ring_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from =E2=80=98__rte_ring_do_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:466:2,
    inlined from =E2=80=98rte_ring_sc_dequeue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:344:9,
    inlined from =E2=80=98rte_ring_sc_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:444:9,
    inlined from =E2=80=98alloc_slot=E2=80=99 at ../lib/hash/rte_cuckoo_has=
h.c:1098:7:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: =E2=80=98memcpy=E2=80=99 w=
riting 32 bytes into
a region of size 4 overflows the destination [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98alloc_slot=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1078:18: note: destination object =E2=80=98sl=
ot_id=E2=80=99 of
size 4
 1078 |         uint32_t slot_id;
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98__rte_ring_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from =E2=80=98__rte_ring_do_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:466:2,
    inlined from =E2=80=98rte_ring_sc_dequeue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:344:9,
    inlined from =E2=80=98rte_ring_sc_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:444:9,
    inlined from =E2=80=98__rte_hash_add_key_with_hash=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1260:6:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: =E2=80=98memcpy=E2=80=99 w=
riting 32 bytes into
a region of size 4 overflows the destination [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__rte_hash_add_key_with=
_hash=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1114:18: note: destination object =E2=80=98ex=
t_bkt_id=E2=80=99 of
size 4
 1114 |         uint32_t ext_bkt_id =3D 0;
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98__rte_ring_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from =E2=80=98__rte_ring_do_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:466:2,
    inlined from =E2=80=98rte_ring_sc_dequeue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:344:9,
    inlined from =E2=80=98rte_ring_sc_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:444:9,
    inlined from =E2=80=98__rte_hash_add_key_with_hash=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1267:5:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: =E2=80=98memcpy=E2=80=99 w=
riting 32 bytes into
a region of size 4 overflows the destination [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__rte_hash_add_key_with=
_hash=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1114:18: note: destination object =E2=80=98ex=
t_bkt_id=E2=80=99 of
size 4
 1114 |         uint32_t ext_bkt_id =3D 0;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98__hash_rcu_qsbr_free_resource=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1616:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 12 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__hash_rcu_qsbr_free_re=
source=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1592:40: note: at offset [4, 16] into source
object =E2=80=98rcu_dq_entry=E2=80=99 of size 16
 1592 |         struct __rte_hash_rcu_dq_entry rcu_dq_entry =3D
      |                                        ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98__rte_hash_del_key_with_hash=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1899:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__rte_hash_del_key_with=
_hash=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1831:18: note: source object =E2=80=98index=
=E2=80=99 of size 4
 1831 |         uint32_t index =3D EMPTY_SLOT;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_free_key_with_position=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1981:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_free_key_with_=
position=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1978:26: note: source object =E2=80=98index=
=E2=80=99 of size 4
 1978 |                 uint32_t index =3D h->ext_bkt_to_free[position];
      |                          ^
[284/284] Linking target app/dpdk-testpmd
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_create=E2=80=99 at ../lib/hash/rte_cucko=
o_hash.c:375:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_create=E2=80=
=99:
../lib/hash/rte_cuckoo_hash.c:184:18: note: source object =E2=80=98i=E2=80=
=99 of size 4
  184 |         uint32_t i;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_create=E2=80=99 at ../lib/hash/rte_cucko=
o_hash.c:524:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_create=E2=80=
=99:
../lib/hash/rte_cuckoo_hash.c:184:18: note: source object =E2=80=98i=E2=80=
=99 of size 4
  184 |         uint32_t i;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_reset=E2=80=99 at ../lib/hash/rte_cuckoo=
_hash.c:730:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_reset=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:693:32: note: source object =E2=80=98i=E2=80=
=99 of size 4
  693 |         uint32_t tot_ring_cnt, i;
      |                                ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_reset=E2=80=99 at ../lib/hash/rte_cuckoo=
_hash.c:735:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_reset=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:693:32: note: source object =E2=80=98i=E2=80=
=99 of size 4
  693 |         uint32_t tot_ring_cnt, i;
      |                                ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98enqueue_slot_back=E2=80=99 at ../lib/hash/rte_cuc=
koo_hash.c:761:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98enqueue_slot_back=E2=80=
=99:
../lib/hash/rte_cuckoo_hash.c:755:26: note: source object =E2=80=98slot_id=
=E2=80=99 of size 4
  755 |                 uint32_t slot_id)
      |                          ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98__rte_ring_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from =E2=80=98__rte_ring_do_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:466:2,
    inlined from =E2=80=98rte_ring_sc_dequeue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:344:9,
    inlined from =E2=80=98rte_ring_sc_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:444:9,
    inlined from =E2=80=98alloc_slot=E2=80=99 at ../lib/hash/rte_cuckoo_has=
h.c:1098:7:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: =E2=80=98memcpy=E2=80=99 w=
riting 32 bytes into
a region of size 4 overflows the destination [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98alloc_slot=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1078:18: note: destination object =E2=80=98sl=
ot_id=E2=80=99 of
size 4
 1078 |         uint32_t slot_id;
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98__rte_ring_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from =E2=80=98__rte_ring_do_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:466:2,
    inlined from =E2=80=98rte_ring_sc_dequeue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:344:9,
    inlined from =E2=80=98rte_ring_sc_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:444:9,
    inlined from =E2=80=98__rte_hash_add_key_with_hash=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1260:6:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: =E2=80=98memcpy=E2=80=99 w=
riting 32 bytes into
a region of size 4 overflows the destination [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__rte_hash_add_key_with=
_hash=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1114:18: note: destination object =E2=80=98ex=
t_bkt_id=E2=80=99 of
size 4
 1114 |         uint32_t ext_bkt_id =3D 0;
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98__rte_ring_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from =E2=80=98__rte_ring_do_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:466:2,
    inlined from =E2=80=98rte_ring_sc_dequeue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:344:9,
    inlined from =E2=80=98rte_ring_sc_dequeue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:444:9,
    inlined from =E2=80=98__rte_hash_add_key_with_hash=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1267:5:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: =E2=80=98memcpy=E2=80=99 w=
riting 32 bytes into
a region of size 4 overflows the destination [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__rte_hash_add_key_with=
_hash=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1114:18: note: destination object =E2=80=98ex=
t_bkt_id=E2=80=99 of
size 4
 1114 |         uint32_t ext_bkt_id =3D 0;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98__hash_rcu_qsbr_free_resource=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1616:3:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 12 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__hash_rcu_qsbr_free_re=
source=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1592:40: note: at offset [4, 16] into source
object =E2=80=98rcu_dq_entry=E2=80=99 of size 16
 1592 |         struct __rte_hash_rcu_dq_entry rcu_dq_entry =3D
      |                                        ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98__rte_hash_del_key_with_hash=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1899:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98__rte_hash_del_key_with=
_hash=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1831:18: note: source object =E2=80=98index=
=E2=80=99 of size 4
 1831 |         uint32_t index =3D EMPTY_SLOT;
      |                  ^
In function =E2=80=98__rte_ring_enqueue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:141:3,
    inlined from =E2=80=98__rte_ring_enqueue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:160:2,
    inlined from =E2=80=98__rte_ring_do_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:419:2,
    inlined from =E2=80=98rte_ring_sp_enqueue_bulk_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:159:9,
    inlined from =E2=80=98rte_ring_sp_enqueue_elem=E2=80=99 at
../lib/ring/rte_ring_elem.h:260:9,
    inlined from =E2=80=98rte_hash_free_key_with_position=E2=80=99 at
../lib/hash/rte_cuckoo_hash.c:1981:4:
../lib/ring/rte_ring_elem_pvt.h:108:25: warning: =E2=80=98memcpy=E2=80=99 r=
eading 32 bytes from
a region of size 4 [-Wstringop-overread]
  108 |                         memcpy((void *)(ring + idx),
      |                         ^
../lib/hash/rte_cuckoo_hash.c: In function =E2=80=98rte_hash_free_key_with_=
position=E2=80=99:
../lib/hash/rte_cuckoo_hash.c:1978:26: note: source object =E2=80=98index=
=E2=80=99 of size 4
 1978 |                 uint32_t index =3D h->ext_bkt_to_free[position];
      |                          ^

--=20
You are receiving this mail because:
You are on the CC list for the bug.=
