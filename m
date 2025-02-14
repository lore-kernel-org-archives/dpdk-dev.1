Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF782C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 09:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81FB4064F;
	Fri, 14 Feb 2025 10:47:54 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 953954064A
 for <dev@dpdk.org>; Fri, 14 Feb 2025 10:47:53 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 74A2146224; Fri, 14 Feb 2025 10:47:53 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1661] mlx5: rte_flow_create can cause a seg fault
Date: Fri, 14 Feb 2025 09:47:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1661-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17395264730.42ab59.1307357
Content-Transfer-Encoding: 7bit
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


--17395264730.42ab59.1307357
Date: Fri, 14 Feb 2025 10:47:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1661

            Bug ID: 1661
           Summary: mlx5: rte_flow_create can cause a seg fault
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: ktraynor@redhat.com
  Target Milestone: ---

Depending on NIC configuration, a seg fault can occur when calling
rte_flow_create() because mlx5_flow_null_drv_ops does not have a .list_crea=
te
implementation.

Details:

Driver type gets selected from flow_get_drv_type() and can return
MLX5_FLOW_TYPE_MAX


 4180=E2=94=82 flow_get_drv_type(struct rte_eth_dev *dev, const struct rte_=
flow_attr
*attr)
 4181=E2=94=82 {
 4182=E2=94=82         struct mlx5_priv *priv =3D dev->data->dev_private;
 4183=E2=94=82         /* The OS can determine first a specific flow type (=
DV, VERBS)
*/
 4184=E2=94=82         enum mlx5_flow_drv_type type =3D mlx5_flow_os_get_ty=
pe();
 4185=E2=94=82
 4186=E2=94=82         if (type !=3D MLX5_FLOW_TYPE_MAX)
 4187=E2=94=82                 return type;
 4188=E2=94=82         /*
 4189=E2=94=82          * Currently when dv_flow_en =3D=3D 2, only HW steer=
ing engine is
 4190=E2=94=82          * supported. New engines can also be chosen here if=
 ready.
 4191=E2=94=82          */
 4192=E2=94=82         if (priv->sh->config.dv_flow_en =3D=3D 2)
 4193=E2=94=82                 return MLX5_FLOW_TYPE_HW;
 4194=E2=94=82         if (!attr)
 4195=E2=94=82                 return MLX5_FLOW_TYPE_MIN;
 4196=E2=94=82         /* If no OS specific type - continue with DV/VERBS s=
election */
 4197=E2=94=82         if (attr->transfer && priv->sh->config.dv_esw_en)
 4198=E2=94=82                 type =3D MLX5_FLOW_TYPE_DV;
 4199=E2=94=82         if (!attr->transfer)
 4200=E2=94=82                 type =3D priv->sh->config.dv_flow_en ? MLX5_=
FLOW_TYPE_DV :
 4201=E2=94=82=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
MLX5_FLOW_TYPE_VERBS;
 4202=E2=94=9C>        return type;
 4203=E2=94=82 }

(gdb) p type
$1 =3D MLX5_FLOW_TYPE_MAX
(gdb) p attr->transfer
$2 =3D 1
(gdb) p priv->sh->config
$5 =3D {tx_pp =3D 0, tx_skew =3D 0, reclaim_mode =3D 0, dv_esw_en =3D 0, dv=
_flow_en =3D 1,
dv_xmeta_en =3D 0, dv_miss_info =3D 0, l3_vxlan_en =3D 0, vf_nl_en =3D 1, l=
acp_by_user
=3D
0, decap_en =3D 1, hw_fcs_strip =3D 1, allow_duplicate_pattern =3D 1, lro_a=
llowed =3D
1, cnt_svc =3D {service_core =3D 0, cycle_time =3D 500}, fdb_def_rule =3D 1,
repr_matching
 =3D 1}

In this case flow_get_drv_ops() selects mlx5_flow_null_drv_ops, which does =
not
have a .list_create implementation.


 8032=E2=94=82 uintptr_t
 8033=E2=94=82 mlx5_flow_list_create(struct rte_eth_dev *dev, enum mlx5_flo=
w_type type,
 8034=E2=94=82                       const struct rte_flow_attr *attr,
 8035=E2=94=82                       const struct rte_flow_item items[],
 8036=E2=94=82                       const struct rte_flow_action actions[],
 8037=E2=94=82                       bool external, struct rte_flow_error *=
error)
 8038=E2=94=82 {
 8039=E2=94=82         const struct mlx5_flow_driver_ops *fops;
 8040=E2=94=82         enum mlx5_flow_drv_type drv_type =3D flow_get_drv_ty=
pe(dev, attr);
 8041=E2=94=82
 8042=E2=94=82         fops =3D flow_get_drv_ops(drv_type);
 8043=E2=94=9C>        return fops->list_create(dev, type, attr, items, act=
ions,
external,
 8044=E2=94=82                 error);
 8045=E2=94=82 }

(gdb) p drv_type
$1 =3D MLX5_FLOW_TYPE_MAX
(gdb) p fops
$2 =3D (const struct mlx5_flow_driver_ops *) 0x45b34e0 <mlx5_flow_null_drv_=
ops>
(gdb) p fops->list_create
$3 =3D (mlx5_flow_list_create_t) 0x0

As there is no list_create, it causes a seg fault

(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x000000000158a6b1 in mlx5_flow_list_create (dev=3D0x4e87500
<rte_eth_devices+33152>, type=3DMLX5_FLOW_TYPE_GEN, attr=3D0x7f0095666c98,
items=3D0x7f008000e1a0, actions=3D0x7f008000dd10, external=3Dtrue,
error=3D0x7f0095666c30) at ../drivers/net/mlx
5/mlx5_flow.c:8043
#2  0x000000000158a535 in mlx5_flow_create (dev=3D0x4e87500
<rte_eth_devices+33152>, attr=3D0x7f0095666c98, items=3D0x7f008000e1a0,
actions=3D0x7f008000dd10, error=3D0x7f0095666c30) at
../drivers/net/mlx5/mlx5_flow.c:8019
#3  0x00000000037a51af in rte_flow_create (port_id=3D2, attr=3D0x7f0095666c=
98,
pattern=3D0x7f008000e1a0, actions=3D0x7f008000dd10, error=3D0x7f0095666c30)=
 at
../lib/ethdev/rte_flow.c:420
#4  0x0000000003a86d6f in netdev_dpdk_rte_flow_create (netdev=3D0x17d15a5c0,
attr=3D0x7f0095666c98, items=3D0x7f008000e1a0, actions=3D0x7f008000dd10,
error=3D0x7f0095666c30) at lib/netdev-dpdk.c:6539
#5  0x0000000003a8b798 in netdev_offload_dpdk_flow_create (netdev=3D0x17d15=
a5c0,
attr=3D0x7f0095666c98, flow_patterns=3D0x7f0095666d00, flow_actions=3D0x7f0=
095666c50,
error=3D0x7f0095666c30) at lib/netdev-offload-dpdk.c:927
#6  0x0000000003a8f3af in netdev_offload_dpdk_actions (netdev=3D0x17d15a5c0,
patterns=3D0x7f0095666d00, nl_actions=3D0x7f0088005be0, actions_len=3D8) at
lib/netdev-offload-dpdk.c:2292
#7  0x0000000003a8f563 in netdev_offload_dpdk_add_flow (netdev=3D0x17d15a5c=
0,
match=3D0x7f0088009010, nl_actions=3D0x7f0088005be0, actions_len=3D8,
ufid=3D0x7f0088008888, info=3D0x7f0095666ed0) at lib/netdev-offload-dpdk.c:=
2322
#8  0x0000000003a8fb27 in netdev_offload_dpdk_flow_put (netdev=3D0x17d15a5c=
0,
match=3D0x7f0088009010, actions=3D0x7f0088005be0, actions_len=3D8,
ufid=3D0x7f0088008888, info=3D0x7f0095666ed0, stats=3D0x0) at
lib/netdev-offload-dpdk.c:2456
#9  0x000000000394800b in netdev_flow_put (netdev=3D0x17d15a5c0,
match=3D0x7f0088009010, actions=3D0x7f0088005be0, act_len=3D8, ufid=3D0x7f0=
088008888,
info=3D0x7f0095666ed0, stats=3D0x0) at lib/netdev-offload.c:318
#10 0x00000000038f19a5 in dp_netdev_flow_offload_put (item=3D0x7f0088008fe0=
) at
lib/dpif-netdev.c:2853
#11 0x00000000038f1a83 in dp_offload_flow (item=3D0x7f0088008fe0) at
lib/dpif-netdev.c:2889
#12 0x00000000038f1d27 in dp_netdev_flow_offload_main (arg=3D0x7f0090001700=
) at
lib/dpif-netdev.c:2960
#13 0x00000000039d618f in ovsthread_wrapper (aux_=3D0x7f0090002dd0) at
lib/ovs-thread.c:429
#14 0x00007f00c60631ca in start_thread () from /lib64/libpthread.so.0
#15 0x00007f00c3337e73 in clone () from /lib64/libc.so.6

Simple solution to avoid seg fault is to create a null ops implementation f=
or
list_create.

I'm not sure right now if there is an additional bug with the device flow
driver ops selection as it requires more knowledge about NIC config and dev=
ice
flow drivers selection.

For now, I will send a patch to fix the seg fault. Would be helpful if some=
one
from Nvidia could review the device flow driver selection for correctness a=
nd
user docs on flow modes.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17395264730.42ab59.1307357
Date: Fri, 14 Feb 2025 10:47:53 +0100
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - mlx5: rte_flow_create can cause a seg fault"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1661">1661</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>mlx5: rte_flow_create can cause a seg fault
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
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
          <td>ktraynor&#64;redhat.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Depending on NIC configuration, a =
seg fault can occur when calling
rte_flow_create() because mlx5_flow_null_drv_ops does not have a .list_crea=
te
implementation.

Details:

Driver type gets selected from flow_get_drv_type() and can return
MLX5_FLOW_TYPE_MAX


 4180=E2=94=82 flow_get_drv_type(struct rte_eth_dev *dev, const struct rte_=
flow_attr
*attr)
 4181=E2=94=82 {
 4182=E2=94=82         struct mlx5_priv *priv =3D dev-&gt;data-&gt;dev_priv=
ate;
 4183=E2=94=82         /* The OS can determine first a specific flow type (=
DV, VERBS)
*/
 4184=E2=94=82         enum mlx5_flow_drv_type type =3D mlx5_flow_os_get_ty=
pe();
 4185=E2=94=82
 4186=E2=94=82         if (type !=3D MLX5_FLOW_TYPE_MAX)
 4187=E2=94=82                 return type;
 4188=E2=94=82         /*
 4189=E2=94=82          * Currently when dv_flow_en =3D=3D 2, only HW steer=
ing engine is
 4190=E2=94=82          * supported. New engines can also be chosen here if=
 ready.
 4191=E2=94=82          */
 4192=E2=94=82         if (priv-&gt;sh-&gt;config.dv_flow_en =3D=3D 2)
 4193=E2=94=82                 return MLX5_FLOW_TYPE_HW;
 4194=E2=94=82         if (!attr)
 4195=E2=94=82                 return MLX5_FLOW_TYPE_MIN;
 4196=E2=94=82         /* If no OS specific type - continue with DV/VERBS s=
election */
 4197=E2=94=82         if (attr-&gt;transfer &amp;&amp; priv-&gt;sh-&gt;con=
fig.dv_esw_en)
 4198=E2=94=82                 type =3D MLX5_FLOW_TYPE_DV;
 4199=E2=94=82         if (!attr-&gt;transfer)
 4200=E2=94=82                 type =3D priv-&gt;sh-&gt;config.dv_flow_en ?=
 MLX5_FLOW_TYPE_DV :
 4201=E2=94=82=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
MLX5_FLOW_TYPE_VERBS;
 4202=E2=94=9C&gt;        return type;
 4203=E2=94=82 }

(gdb) p type
$1 =3D MLX5_FLOW_TYPE_MAX
(gdb) p attr-&gt;transfer
$2 =3D 1
(gdb) p priv-&gt;sh-&gt;config
$5 =3D {tx_pp =3D 0, tx_skew =3D 0, reclaim_mode =3D 0, dv_esw_en =3D 0, dv=
_flow_en =3D 1,
dv_xmeta_en =3D 0, dv_miss_info =3D 0, l3_vxlan_en =3D 0, vf_nl_en =3D 1, l=
acp_by_user
=3D
0, decap_en =3D 1, hw_fcs_strip =3D 1, allow_duplicate_pattern =3D 1, lro_a=
llowed =3D
1, cnt_svc =3D {service_core =3D 0, cycle_time =3D 500}, fdb_def_rule =3D 1,
repr_matching
 =3D 1}

In this case flow_get_drv_ops() selects mlx5_flow_null_drv_ops, which does =
not
have a .list_create implementation.


 8032=E2=94=82 uintptr_t
 8033=E2=94=82 mlx5_flow_list_create(struct rte_eth_dev *dev, enum mlx5_flo=
w_type type,
 8034=E2=94=82                       const struct rte_flow_attr *attr,
 8035=E2=94=82                       const struct rte_flow_item items[],
 8036=E2=94=82                       const struct rte_flow_action actions[],
 8037=E2=94=82                       bool external, struct rte_flow_error *=
error)
 8038=E2=94=82 {
 8039=E2=94=82         const struct mlx5_flow_driver_ops *fops;
 8040=E2=94=82         enum mlx5_flow_drv_type drv_type =3D flow_get_drv_ty=
pe(dev, attr);
 8041=E2=94=82
 8042=E2=94=82         fops =3D flow_get_drv_ops(drv_type);
 8043=E2=94=9C&gt;        return fops-&gt;list_create(dev, type, attr, item=
s, actions,
external,
 8044=E2=94=82                 error);
 8045=E2=94=82 }

(gdb) p drv_type
$1 =3D MLX5_FLOW_TYPE_MAX
(gdb) p fops
$2 =3D (const struct mlx5_flow_driver_ops *) 0x45b34e0 &lt;mlx5_flow_null_d=
rv_ops&gt;
(gdb) p fops-&gt;list_create
$3 =3D (mlx5_flow_list_create_t) 0x0

As there is no list_create, it causes a seg fault

(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x000000000158a6b1 in mlx5_flow_list_create (dev=3D0x4e87500
&lt;rte_eth_devices+33152&gt;, type=3DMLX5_FLOW_TYPE_GEN, attr=3D0x7f009566=
6c98,
items=3D0x7f008000e1a0, actions=3D0x7f008000dd10, external=3Dtrue,
error=3D0x7f0095666c30) at ../drivers/net/mlx
5/mlx5_flow.c:8043
#2  0x000000000158a535 in mlx5_flow_create (dev=3D0x4e87500
&lt;rte_eth_devices+33152&gt;, attr=3D0x7f0095666c98, items=3D0x7f008000e1a=
0,
actions=3D0x7f008000dd10, error=3D0x7f0095666c30) at
../drivers/net/mlx5/mlx5_flow.c:8019
#3  0x00000000037a51af in rte_flow_create (port_id=3D2, attr=3D0x7f0095666c=
98,
pattern=3D0x7f008000e1a0, actions=3D0x7f008000dd10, error=3D0x7f0095666c30)=
 at
../lib/ethdev/rte_flow.c:420
#4  0x0000000003a86d6f in netdev_dpdk_rte_flow_create (netdev=3D0x17d15a5c0,
attr=3D0x7f0095666c98, items=3D0x7f008000e1a0, actions=3D0x7f008000dd10,
error=3D0x7f0095666c30) at lib/netdev-dpdk.c:6539
#5  0x0000000003a8b798 in netdev_offload_dpdk_flow_create (netdev=3D0x17d15=
a5c0,
attr=3D0x7f0095666c98, flow_patterns=3D0x7f0095666d00, flow_actions=3D0x7f0=
095666c50,
error=3D0x7f0095666c30) at lib/netdev-offload-dpdk.c:927
#6  0x0000000003a8f3af in netdev_offload_dpdk_actions (netdev=3D0x17d15a5c0,
patterns=3D0x7f0095666d00, nl_actions=3D0x7f0088005be0, actions_len=3D8) at
lib/netdev-offload-dpdk.c:2292
#7  0x0000000003a8f563 in netdev_offload_dpdk_add_flow (netdev=3D0x17d15a5c=
0,
match=3D0x7f0088009010, nl_actions=3D0x7f0088005be0, actions_len=3D8,
ufid=3D0x7f0088008888, info=3D0x7f0095666ed0) at lib/netdev-offload-dpdk.c:=
2322
#8  0x0000000003a8fb27 in netdev_offload_dpdk_flow_put (netdev=3D0x17d15a5c=
0,
match=3D0x7f0088009010, actions=3D0x7f0088005be0, actions_len=3D8,
ufid=3D0x7f0088008888, info=3D0x7f0095666ed0, stats=3D0x0) at
lib/netdev-offload-dpdk.c:2456
#9  0x000000000394800b in netdev_flow_put (netdev=3D0x17d15a5c0,
match=3D0x7f0088009010, actions=3D0x7f0088005be0, act_len=3D8, ufid=3D0x7f0=
088008888,
info=3D0x7f0095666ed0, stats=3D0x0) at lib/netdev-offload.c:318
#10 0x00000000038f19a5 in dp_netdev_flow_offload_put (item=3D0x7f0088008fe0=
) at
lib/dpif-netdev.c:2853
#11 0x00000000038f1a83 in dp_offload_flow (item=3D0x7f0088008fe0) at
lib/dpif-netdev.c:2889
#12 0x00000000038f1d27 in dp_netdev_flow_offload_main (arg=3D0x7f0090001700=
) at
lib/dpif-netdev.c:2960
#13 0x00000000039d618f in ovsthread_wrapper (aux_=3D0x7f0090002dd0) at
lib/ovs-thread.c:429
#14 0x00007f00c60631ca in start_thread () from /lib64/libpthread.so.0
#15 0x00007f00c3337e73 in clone () from /lib64/libc.so.6

Simple solution to avoid seg fault is to create a null ops implementation f=
or
list_create.

I'm not sure right now if there is an additional bug with the device flow
driver ops selection as it requires more knowledge about NIC config and dev=
ice
flow drivers selection.

For now, I will send a patch to fix the seg fault. Would be helpful if some=
one
from Nvidia could review the device flow driver selection for correctness a=
nd
user docs on flow modes.
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
?id=3D1661">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17395264730.42ab59.1307357--
