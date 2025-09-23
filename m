Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ECDCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 04:23:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C8724021F;
	Tue, 23 Sep 2025 06:23:39 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9D82040144
 for <dev@dpdk.org>; Tue, 23 Sep 2025 06:23:37 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8F90B46F53; Tue, 23 Sep 2025 06:23:37 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1790] warnings in CNXK when built with LTO
Date: Tue, 23 Sep 2025 04:23:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1790-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17586014170.E253.233700
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
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


--17586014170.E253.233700
Date: Tue, 23 Sep 2025 06:23:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1790

            Bug ID: 1790
           Summary: warnings in CNXK when built with LTO
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

If DPDK is built with link time optimization the compiler can see across fi=
le
scope and detect more errors like this.

$ meson setup build -Db_lto=3Dtrue && ninja --quiet -C build

In function =E2=80=98parse_flag=E2=80=99,
    inlined from =E2=80=98kvargs_process_common=E2=80=99 at ../lib/kvargs/r=
te_kvargs.c:187:9,
    inlined from =E2=80=98rte_kvargs_process=E2=80=99 at ../lib/kvargs/rte_=
kvargs.c:203:9,
    inlined from =E2=80=98cnxk_ethdev_parse_devargs=E2=80=99 at
../drivers/net/cnxk/cnxk_ethdev_devargs.c:371:2:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes int=
o a
region of size 1 [-Wstringop-overflow=3D]
  166 |         *(uint16_t *)extra_args =3D atoi(value);
../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function
=E2=80=98cnxk_ethdev_parse_devargs=E2=80=99:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:306:17: note: destination object
=E2=80=98force_tail_drop=E2=80=99 of size 1
  306 |         uint8_t force_tail_drop =3D 0;
      |                 ^
In function =E2=80=98parse_flag=E2=80=99,
    inlined from =E2=80=98kvargs_process_common=E2=80=99 at ../lib/kvargs/r=
te_kvargs.c:187:9,
    inlined from =E2=80=98rte_kvargs_process=E2=80=99 at ../lib/kvargs/rte_=
kvargs.c:203:9,
    inlined from =E2=80=98cnxk_ethdev_parse_devargs=E2=80=99 at
../drivers/net/cnxk/cnxk_ethdev_devargs.c:372:2:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes int=
o a
region of size 1 [-Wstringop-overflow=3D]
  166 |         *(uint16_t *)extra_args =3D atoi(value);
../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function
=E2=80=98cnxk_ethdev_parse_devargs=E2=80=99:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:312:17: note: destination object
=E2=80=98dis_xqe_drop=E2=80=99 of size 1
  312 |         uint8_t dis_xqe_drop =3D 0;
      |                 ^
../drivers/common/cnxk/roc_platform.c: In function =E2=80=98irq_config=E2=
=80=99:
../drivers/common/cnxk/roc_platform.c:55:14: warning: argument to
variable-length array is too large [-Wvla-larger-than=3D]
   55 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^
../drivers/common/cnxk/roc_platform.c:55:14: note: limit is 922337203685477=
5807
bytes, but argument is 18446744073709551548
../drivers/common/cnxk/roc_platform.c: In function =E2=80=98irq_init=E2=80=
=99:
../drivers/common/cnxk/roc_platform.c:91:14: warning: argument to
variable-length array is too large [-Wvla-larger-than=3D]
   91 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^
../drivers/common/cnxk/roc_platform.c:91:14: note: limit is 922337203685477=
5807
bytes, but argument is 18446744073709551548
In function =E2=80=98roc_ow_reass_inb_sa_init=E2=80=99,
    inlined from =E2=80=98nix_inl_reass_inb_sa_tbl_setup=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:610:2,
    inlined from =E2=80=98nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1417:8,
    inlined from =E2=80=98roc_nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1439:9:
../drivers/common/cnxk/roc_ie_ow.c:35:9: warning: =E2=80=98memset=E2=80=99 =
writing 808 bytes
into a region of size 1 overflows the destination [-Wstringop-overflow=3D]
   35 |         memset(sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
      |         ^
In function =E2=80=98nix_inl_reass_inb_sa_tbl_setup=E2=80=99,
    inlined from =E2=80=98nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1417:8,
    inlined from =E2=80=98roc_nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1439:9:
../drivers/common/cnxk/roc_nix_inl.c:603:40: note: destination object of si=
ze 1
allocated by =E2=80=98rte_zmalloc=E2=80=99
  603 |         nix->inb_sa_base[profile_id] =3D plt_zmalloc(inb_sa_sz * ma=
x_sa,
ROC_NIX_INL_SA_BASE_ALIGN);
      |

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17586014170.E253.233700
Date: Tue, 23 Sep 2025 06:23:37 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - warnings in CNXK when built with LTO"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1790">1790</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>warnings in CNXK when built with LTO
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">If DPDK is built with link time op=
timization the compiler can see across file
scope and detect more errors like this.

$ meson setup build -Db_lto=3Dtrue &amp;&amp; ninja --quiet -C build

In function =E2=80=98parse_flag=E2=80=99,
    inlined from =E2=80=98kvargs_process_common=E2=80=99 at ../lib/kvargs/r=
te_kvargs.c:187:9,
    inlined from =E2=80=98rte_kvargs_process=E2=80=99 at ../lib/kvargs/rte_=
kvargs.c:203:9,
    inlined from =E2=80=98cnxk_ethdev_parse_devargs=E2=80=99 at
../drivers/net/cnxk/cnxk_ethdev_devargs.c:371:2:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes int=
o a
region of size 1 [-Wstringop-overflow=3D]
  166 |         *(uint16_t *)extra_args =3D atoi(value);
../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function
=E2=80=98cnxk_ethdev_parse_devargs=E2=80=99:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:306:17: note: destination object
=E2=80=98force_tail_drop=E2=80=99 of size 1
  306 |         uint8_t force_tail_drop =3D 0;
      |                 ^
In function =E2=80=98parse_flag=E2=80=99,
    inlined from =E2=80=98kvargs_process_common=E2=80=99 at ../lib/kvargs/r=
te_kvargs.c:187:9,
    inlined from =E2=80=98rte_kvargs_process=E2=80=99 at ../lib/kvargs/rte_=
kvargs.c:203:9,
    inlined from =E2=80=98cnxk_ethdev_parse_devargs=E2=80=99 at
../drivers/net/cnxk/cnxk_ethdev_devargs.c:372:2:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes int=
o a
region of size 1 [-Wstringop-overflow=3D]
  166 |         *(uint16_t *)extra_args =3D atoi(value);
../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function
=E2=80=98cnxk_ethdev_parse_devargs=E2=80=99:
../drivers/net/cnxk/cnxk_ethdev_devargs.c:312:17: note: destination object
=E2=80=98dis_xqe_drop=E2=80=99 of size 1
  312 |         uint8_t dis_xqe_drop =3D 0;
      |                 ^
../drivers/common/cnxk/roc_platform.c: In function =E2=80=98irq_config=E2=
=80=99:
../drivers/common/cnxk/roc_platform.c:55:14: warning: argument to
variable-length array is too large [-Wvla-larger-than=3D]
   55 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^
../drivers/common/cnxk/roc_platform.c:55:14: note: limit is 922337203685477=
5807
bytes, but argument is 18446744073709551548
../drivers/common/cnxk/roc_platform.c: In function =E2=80=98irq_init=E2=80=
=99:
../drivers/common/cnxk/roc_platform.c:91:14: warning: argument to
variable-length array is too large [-Wvla-larger-than=3D]
   91 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^
../drivers/common/cnxk/roc_platform.c:91:14: note: limit is 922337203685477=
5807
bytes, but argument is 18446744073709551548
In function =E2=80=98roc_ow_reass_inb_sa_init=E2=80=99,
    inlined from =E2=80=98nix_inl_reass_inb_sa_tbl_setup=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:610:2,
    inlined from =E2=80=98nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1417:8,
    inlined from =E2=80=98roc_nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1439:9:
../drivers/common/cnxk/roc_ie_ow.c:35:9: warning: =E2=80=98memset=E2=80=99 =
writing 808 bytes
into a region of size 1 overflows the destination [-Wstringop-overflow=3D]
   35 |         memset(sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
      |         ^
In function =E2=80=98nix_inl_reass_inb_sa_tbl_setup=E2=80=99,
    inlined from =E2=80=98nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1417:8,
    inlined from =E2=80=98roc_nix_inl_inb_init=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl.c:1439:9:
../drivers/common/cnxk/roc_nix_inl.c:603:40: note: destination object of si=
ze 1
allocated by =E2=80=98rte_zmalloc=E2=80=99
  603 |         nix-&gt;inb_sa_base[profile_id] =3D plt_zmalloc(inb_sa_sz *=
 max_sa,
ROC_NIX_INL_SA_BASE_ALIGN);
      |
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1790">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17586014170.E253.233700--
