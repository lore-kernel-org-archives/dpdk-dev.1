Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3517CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 23:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC5D040151;
	Fri, 24 Oct 2025 01:47:03 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BB1E340144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 01:47:01 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B5391489BE; Fri, 24 Oct 2025 01:47:01 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1810] net/mlx: possible misuse of comma operator
Date: Thu, 23 Oct 2025 23:47:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 20.11
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
Message-ID: <bug-1810-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1810

            Bug ID: 1810
           Summary: net/mlx: possible misuse of comma operator
           Product: DPDK
           Version: 20.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

If DPDK is built with clang and -Wcomma is enabled for drivers then both ml=
x4
and mlx5 have comma where semicolon should be used.

[1175/3622] Compiling C object
drivers/libtmp_rte_net_mlx4.a.p/net_mlx4_mlx4_rxtx.c.o
../drivers/net/mlx4/mlx4_rxtx.c:641:46: warning: possible misuse of comma
operator here [-Wcomma]
  641 |                 pv[(*pv_counter)++].val =3D *(uint32_t *)from,
      |                                                            ^
../drivers/net/mlx4/mlx4_rxtx.c:641:3: note: cast expression to void to sil=
ence
warning
  641 |                 pv[(*pv_counter)++].val =3D *(uint32_t *)from,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 (void)(                                    )
1 warning generated.
[1189/3622] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_nta_split.c.o
../drivers/net/mlx5/mlx5_nta_split.c:348:53: warning: possible misuse of co=
mma
operator here [-Wcomma]
  348 |         actions[1].type =3D RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
      |                                                            ^
../drivers/net/mlx5/mlx5_nta_split.c:348:2: note: cast expression to void to
silence warning
  348 |         actions[1].type =3D RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         (void)(                                            )
../drivers/net/mlx5/mlx5_nta_split.c:349:28: warning: possible misuse of co=
mma
operator here [-Wcomma]
  349 |         actions[1].conf =3D &rx_meta,
      |                                   ^
../drivers/net/mlx5/mlx5_nta_split.c:349:2: note: cast expression to void to
silence warning
  349 |         actions[1].conf =3D &rx_meta,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         (void)(                   )
2 warnings generated.
[1200/3622] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_linux_mlx5_verbs.c.o
../drivers/net/mlx5/linux/mlx5_verbs.c:886:38: warning: possible misuse of
comma operator here [-Wcomma]
  886 |         qp_attr.qp_type =3D IBV_QPT_RAW_PACKET,
      |                                             ^
../drivers/net/mlx5/linux/mlx5_verbs.c:886:2: note: cast expression to void=
 to
silence warning
  886 |         qp_attr.qp_type =3D IBV_QPT_RAW_PACKET,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         (void)(                             )
1 warning generated.
[1207/3622] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_linux_mlx5_os.c.o
../drivers/net/mlx5/linux/mlx5_os.c:434:37: warning: possible misuse of com=
ma
operator here [-Wcomma]
  434 |         dv_attr.type =3D IBV_FLOW_ATTR_NORMAL,
      |                                            ^
../drivers/net/mlx5/linux/mlx5_os.c:434:2: note: cast expression to void to
silence warning
  434 |         dv_attr.type =3D IBV_FLOW_ATTR_NORMAL,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         (void)(                            )
../drivers/net/mlx5/linux/mlx5_os.c:435:44: warning: possible misuse of com=
ma
operator here [-Wcomma]
  435 |         dv_attr.match_mask =3D (void *)&matcher_mask,
      |                                                   ^
../drivers/net/mlx5/linux/mlx5_os.c:435:2: note: cast expression to void to
silence warning
  435 |         dv_attr.match_mask =3D (void *)&matcher_mask,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         (void)(                                   )
2 warnings generated.
[1224/3622] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_flow.c.o
../drivers/net/mlx5/mlx5_flow.c:11135:55: warning: possible misuse of comma
operator here [-Wcomma]
 11135 |                 ctx->action_rss.func =3D RTE_ETH_HASH_FUNCTION_DEF=
AULT,
       |                                                                   =
  ^
../drivers/net/mlx5/mlx5_flow.c:11135:3: note: cast expression to void to
silence warning
 11135 |                 ctx->action_rss.func =3D RTE_ETH_HASH_FUNCTION_DEF=
AULT,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
       |                 (void)(                                           =
  )
../drivers/net/mlx5/mlx5_flow.c:11136:28: warning: possible misuse of comma
operator here [-Wcomma]
 11136 |                 ctx->action_rss.level =3D 0,
       |                                          ^
../drivers/net/mlx5/mlx5_flow.c:11136:3: note: cast expression to void to
silence warning
 11136 |                 ctx->action_rss.level =3D 0,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
       |                 (void)(                  )
../drivers/net/mlx5/mlx5_flow.c:11137:48: warning: possible misuse of comma
operator here [-Wcomma]
 11137 |                 ctx->action_rss.types =3D priv->rss_conf.rss_hf,
       |                                                              ^
../drivers/net/mlx5/mlx5_flow.c:11137:3: note: cast expression to void to
silence warning
 11137 |                 ctx->action_rss.types =3D priv->rss_conf.rss_hf,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                 (void)(                                      )
../drivers/net/mlx5/mlx5_flow.c:11138:55: warning: possible misuse of comma
operator here [-Wcomma]
 11138 |                 ctx->action_rss.key_len =3D priv->rss_conf.rss_key=
_len,
       |                                                                   =
  ^
../drivers/net/mlx5/mlx5_flow.c:11138:3: note: cast expression to void to
silence warning
 11138 |                 ctx->action_rss.key_len =3D priv->rss_conf.rss_key=
_len,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
       |                 (void)(                                           =
  )
../drivers/net/mlx5/mlx5_flow.c:11139:47: warning: possible misuse of comma
operator here [-Wcomma]
 11139 |                 ctx->action_rss.queue_num =3D priv->reta_idx_n,
       |                                                             ^
../drivers/net/mlx5/mlx5_flow.c:11139:3: note: cast expression to void to
silence warning
 11139 |                 ctx->action_rss.queue_num =3D priv->reta_idx_n,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                 (void)(                                     )
../drivers/net/mlx5/mlx5_flow.c:11140:47: warning: possible misuse of comma
operator here [-Wcomma]
 11140 |                 ctx->action_rss.key =3D priv->rss_conf.rss_key,
       |                                                             ^
../drivers/net/mlx5/mlx5_flow.c:11140:3: note: cast expression to void to
silence warning
 11140 |                 ctx->action_rss.key =3D priv->rss_conf.rss_key,
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                 (void)(                                     )
6 warnings generated.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
