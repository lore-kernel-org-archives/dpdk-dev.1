Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3530C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB71840E34;
	Mon, 11 Aug 2025 15:13:19 +0200 (CEST)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 4ED76400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:04:23 +0200 (CEST)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-b3226307787so4248121a12.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 06:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754485462; x=1755090262;
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebTbk8eWWG+l8BnQimggN+JTSMxDySr9txfwJgTGLcU=;
 b=RlkT06WBDiROwzEJGK1PMyNCFoqURd89FSaQ6u3nNw4gOCqCjizqD0icyW/BBCTZ7w
 hruCHLUw1miWvI1MidQSNewZDT7mEkuM+YH0bN5Goej5ymNo7A2H6GX9IICEU82DJENr
 9p8yNtvzGtsZ0u2AcFM+YglDALvEI+QoB0Okd4NxOfn7Qjyy9f+h7aSQpcrgyuof+LCd
 aJL9lCV6+h/r9yAZEwewNs05qiFD4BOYhf7bjFensh4TsJCPRnfxb5aoKxLvaPOLjPzA
 cEFa2P5r2hDQqCYh4gGR/GNU/5jb4CpWn+8gBbg5AJam+XfylekrfQE26iY84KEX9OGa
 lT8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy3iYbTDw8563eMjNmZyZLXvRiwX/ldDzi5xfO7ysdJv13K2XULCzt8YZz9oUgI0xNlN8=@dpdk.org
X-Gm-Message-State: AOJu0YyJL8TycPVW3NYcc4c90ydNuvNlYM1+7m/fF2ESQcUr8FWIGx+B
 56dfEXj/1lvvz7oImcKqDrkfCsNc8k0AJNMJGo93tfYYX2oXiPbaKFh8w8mhYRUY3bEM5dgg4mJ
 85pPhYE20lJAJLwEfMH23FTxtk/4eKkduCnj3V2jexJCRND3a6vxmW1PAG7fwXa9AZE04JD2YSP
 ZS/toZ3JF03MC3KjJlw1KD8KcTZRxcpQINCucuE0VbEeWAl0xODTAcyGmnlNVu4lJWsTS91CM=
X-Gm-Gg: ASbGncum2LFzDsLtW6Do9Ushly8ip7nZwO1MRGLH/Ic9wJLzK/BMIDGuOQ8gWYPvDWX
 fzaSkQk8tmsQo9eqqcOEHaX+/roF0D2ogZTxgLjEyjTMIiJmX9jH0y5wyJKgLYpyz3k5T/0+PTA
 ka9L2yW7GJcsNtPzJptiLQZ1wqm4hRBNHKKfEQVR4xRBOUwQTLeYTfH9Z2wl8C6xuNVzj+LlBVs
 EA+KEj35gfSDbfsGSgbAnFmtP+8az1l+P398wuI+OuAIJWxDbBjstmSHR+BIHc8djVgmVeycz1S
 GliAEV+129EYIsjnV1aoA5R0sftVd+zArFROxqjmMAD8PF79uBrGjq1o9aI6vC1xiqnJcqRw8GH
 iASaYIqQJ9WZIbT9/SVGffRxiRD7S8qmExt54gvHwSb029YrntX2265Dw+PaUaSfJrl5PEZ++rM
 Aw
X-Google-Smtp-Source: AGHT+IFpONnRQ85FWLbvDQh86ihfAinE/rjNjDFMrE4GSryOMR8cJfy3Z7KpQDPCLDAvuvephQwzzd4tYUIv
X-Received: by 2002:a17:902:ea04:b0:242:a3fa:edb4 with SMTP id
 d9443c01a7336-242a3faf12bmr23762755ad.44.1754485461899; 
 Wed, 06 Aug 2025 06:04:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-241e899b4c3sm11147835ad.69.2025.08.06.06.04.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Aug 2025 06:04:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-70e72e81fafso77786967b3.2
 for <dev@dpdk.org>; Wed, 06 Aug 2025 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754485460; x=1755090260; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ebTbk8eWWG+l8BnQimggN+JTSMxDySr9txfwJgTGLcU=;
 b=AtQjZA9Y0eGBZTS5WX3c0k1lS2NbkzA7fnXUE5BOtYfEwNEahEVAm69IzWSLWI8sRA
 kEBKpG+MAzb42UbE/1NW6cy1sVckrLq6yt01uQTtX9aGgsGLbHzKqXRplVhSZKWDe4C0
 AHDi+J0awqVi0m+07QSgqjUwZL1w1wFKJHY2A=
X-Forwarded-Encrypted: i=1;
 AJvYcCXl+tV9cFtJG2o61pUuTjfSEST1RktRkvFFIRf1HKOHQL8muLEZoggzn1SUAqgva6yeW2E=@dpdk.org
X-Received: by 2002:a05:690c:6001:b0:71a:2a7e:9cb with SMTP id
 00721157ae682-71bcc86dffemr27665427b3.21.1754485460161; 
 Wed, 06 Aug 2025 06:04:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6001:b0:71a:2a7e:9cb with SMTP id
 00721157ae682-71bcc86dffemr27664777b3.21.1754485459526; Wed, 06 Aug 2025
 06:04:19 -0700 (PDT)
MIME-Version: 1.0
From: Samar Yadav <samar.yadav@broadcom.com>
Date: Wed, 6 Aug 2025 18:34:07 +0530
X-Gm-Features: Ac12FXytCYwpa-xgdn8hj3paHJK3yXfMdBjSHH6PUem4-YcrTkzWUKyragX2MLY
Message-ID: <CAMuNUcajjLFYAujxN1JVPL_CrPz-3BgtKf69Ds1TuHFFRxgLLA@mail.gmail.com>
Subject: [DPDK] Issue: virtio_user with VLAN offload not tagging VLAN despite
 vlan_tci and ol_flags being set
To: maxime.coquelin@redhat.com, chenbox@nvidia.com, dev@dpdk.org
Cc: Srinivasa Srikanth Podila <srinivasa-srikanth.podila@broadcom.com>, 
 Mukul Sinha <mukul.sinha@broadcom.com>,
 Mohit Chavakula <mohit.chavakula@broadcom.com>, 
 Varun LA <varun.la@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000a7f6b5063bb1fa8b"
X-Mailman-Approved-At: Mon, 11 Aug 2025 15:13:08 +0200
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

--000000000000a7f6b5063bb1fa8b
Content-Type: multipart/alternative; boundary="00000000000094a373063bb1faed"

--00000000000094a373063bb1faed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all/Maxime/Chenbox,

I=E2=80=99m observing an issue with virtio_user (with vhost-net backend) wh=
ere VLAN
offload doesn't seem to insert the VLAN tag, even though both vlan_tci and
ol_flags are set correctly in the mbuf. We are using DPDK Version: 24.11
(custom build) and virtio_user for exception path traffic.

Context


   -

   *Scenario*: When a packet with vlan_tci set is transmitted via
   virtio_user with RTE_ETH_TX_OFFLOAD_VLAN_INSERT enabled, the packet
   received on the parent TAP interface lacks the VLAN tag. It subsequently
   gets dropped, since it was meant for the TAP sub-interface corresponding=
 to
   the VLAN.
   -

   *Expected*: The packet should carry the VLAN tag when seen on the TAP
   interface, allowing it to be delivered to the correct sub-interface.

Observations


   -

   At the point of calling virtio_xmit_pkts():
   -

      vlan_tci is correctly set (e.g., 61).
      -

      ol_flags contains RTE_MBUF_F_TX_VLAN (bit 0) =3D> value =3D 0x1.
      -

   We confirmed the following in GDB just before calling
   virtqueue_enqueue_xmit():

(gdb) p **tx_pkts

$6 =3D { ..., vlan_tci =3D 61, ..., ol_flags =3D 65, ... }

(gdb) p /t tx_pkts.ol_flags

$8 =3D 1000001


The value 65 (0b1000001) confirms that RTE_ETH_TX_OFFLOAD_VLAN_INSERT (bit
0) is set.
Despite this, the packet captured on the TAP interface is a plain Ethernet
frame, with no VLAN tag.

Adding few more outputs more gdb

(gdb) p rte_eth_devices[33]

$4 =3D {rx_pkt_burst =3D 0x558180950c36 <virtio_recv_mergeable_pkts>,
tx_pkt_burst =3D 0x558180952440 <virtio_xmit_pkts>, tx_pkt_prepare =3D
0x558180951fa3 <virtio_xmit_pkts_prepare>, rx_queue_count =3D 0x0,
rx_descriptor_status =3D 0x0,

  tx_queue_count =3D 0x0, tx_descriptor_status =3D 0x0, recycle_tx_mbufs_re=
use
=3D 0x0, recycle_rx_descriptors_refill =3D 0x0, data =3D 0x60005fd8e080,
process_private =3D 0x0, dev_ops =3D 0x55818211e2a0 <virtio_eth_dev_ops>,

  flow_fp_ops =3D 0x55818218d140 <rte_flow_fp_default_ops>, device =3D
0x558185a960b0, intr_handle =3D 0x558185a96160, link_intr_cbs =3D {tqh_firs=
t =3D
0x0, tqh_last =3D 0x5581825a42f8 <rte_eth_devices+547128>}, post_rx_burst_c=
bs
=3D {

    0x0 <repeats 1024 times>}, pre_tx_burst_cbs =3D {0x0 <repeats 1024
times>}, state =3D RTE_ETH_DEV_ATTACHED, security_ctx =3D 0x0}


(gdb) p *rte_eth_devices[33].data

$6 =3D {name =3D "virtio_user0", '\000' <repeats 51 times>, rx_queues =3D
0x60005fc2ef80, tx_queues =3D 0x60005fc2cf00, nb_rx_queues =3D 1, nb_tx_que=
ues
=3D 1, sriov =3D {active =3D 0 '\000', nb_q_per_pool =3D 0 '\000', def_vmdq=
_idx =3D
0, def_pool_q_idx =3D 0},

  dev_private =3D 0x60005fc60380, dev_link =3D {{val64 =3D 34359738367,
{link_speed =3D 4294967295, link_duplex =3D 1, link_autoneg =3D 1, link_sta=
tus =3D
1}}}, dev_conf =3D {link_speeds =3D 0, rxmode =3D {mq_mode =3D RTE_ETH_MQ_R=
X_NONE,
mtu =3D 9000,

      max_lro_pkt_size =3D 0, offloads =3D 8193, reserved_64s =3D {0, 0},
reserved_ptrs =3D {0x0, 0x0}}, txmode =3D {mq_mode =3D RTE_ETH_MQ_TX_NONE,
offloads =3D 32813, pvid =3D 0, hw_vlan_reject_tagged =3D 0 '\000',
hw_vlan_reject_untagged =3D 0 '\000',

      hw_vlan_insert_pvid =3D 0 '\000', reserved_64s =3D {0, 0}, reserved_p=
trs
=3D {0x0, 0x0}}, lpbk_mode =3D 0, rx_adv_conf =3D {rss_conf =3D {rss_key =
=3D 0x0,
rss_key_len =3D 0 '\000', rss_hf =3D 0, algorithm =3D
RTE_ETH_HASH_FUNCTION_DEFAULT},

      vmdq_dcb_conf =3D {nb_queue_pools =3D 0, enable_default_pool =3D 0 '\=
000',
default_pool =3D 0 '\000', nb_pool_maps =3D 0 '\000', pool_map =3D {{vlan_i=
d =3D 0,
pools =3D 0} <repeats 64 times>}, dcb_tc =3D "\000\000\000\000\000\000\000"=
},
dcb_rx_conf =3D {

        nb_tcs =3D 0, dcb_tc =3D "\000\000\000\000\000\000\000"}, vmdq_rx_c=
onf
=3D {nb_queue_pools =3D 0, enable_default_pool =3D 0 '\000', default_pool =
=3D 0
'\000', enable_loop_back =3D 0 '\000', nb_pool_maps =3D 0 '\000', rx_mode =
=3D 0,
pool_map =3D {{

            vlan_id =3D 0, pools =3D 0} <repeats 64 times>}}}, tx_adv_conf =
=3D
{vmdq_dcb_tx_conf =3D {nb_queue_pools =3D 0, dcb_tc =3D
"\000\000\000\000\000\000\000"}, dcb_tx_conf =3D {nb_tcs =3D 0, dcb_tc =3D
"\000\000\000\000\000\000\000"}, vmdq_tx_conf =3D {

        nb_queue_pools =3D 0}}, dcb_capability_en =3D 0, intr_conf =3D {lsc=
 =3D 0,
rxq =3D 0, rmv =3D 0}}, mtu =3D 9000, min_rx_buf_size =3D 4294967295,
rx_mbuf_alloc_failed =3D 0, mac_addrs =3D 0x60005ff404c0, mac_pool_sel =3D =
{0
<repeats 128 times>},

  hash_mac_addrs =3D 0x0, port_id =3D 33, promiscuous =3D 0 '\000', scatter=
ed_rx
=3D 0 '\000', all_multicast =3D 0 '\000', dev_started =3D 1 '\001', lro =3D=
 0
'\000', dev_configured =3D 1 '\001', flow_configured =3D 0 '\000',

  rx_queue_state =3D "\001", '\000' <repeats 1022 times>, tx_queue_state =
=3D
"\001", '\000' <repeats 1022 times>, dev_flags =3D 0, numa_node =3D -1,
vlan_filter_conf =3D {ids =3D {0 <repeats 64 times>}}, owner =3D {id =3D 0,

    name =3D '\000' <repeats 63 times>}, representor_id =3D 0, backer_port_=
id =3D
64, flow_ops_mutex =3D {__data =3D {__lock =3D 0, __count =3D 0, __owner =
=3D 0,
__nusers =3D 0, __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D {_=
_prev =3D
0x0, __next =3D 0x0}},

    __size =3D '\000' <repeats 39 times>, __align =3D 0}}


(gdb) p *(struct virtio_user_dev*)rte_eth_devices[33].data.dev_private

$3 =3D {hw =3D {vqs =3D 0x60005ff40400, guest_features =3D 4563441697,
vtnet_hdr_size =3D 12, started =3D 1 '\001', weak_barriers =3D 1 '\001',
vlan_strip =3D 1 '\001', rx_ol_scatter =3D true, has_tx_offload =3D 1 '\001=
',
has_rx_offload =3D 0 '\000',

    use_vec_rx =3D 0 '\000', use_vec_tx =3D 0 '\000', use_inorder_rx =3D 0
'\000', use_inorder_tx =3D 0 '\000', opened =3D 1 '\001', port_id =3D 33,
mac_addr =3D "\000PV\235#g", get_speed_via_feat =3D false, speed =3D 429496=
7295,
duplex =3D 1 '\001',

    intr_lsc =3D 1 '\001', max_mtu =3D 9698, max_rx_pkt_len =3D 9030, state=
_lock
=3D {locked =3D 0}, inject_pkts =3D 0x0, max_queue_pairs =3D 1, rss_rx_queu=
es =3D 0,
rss_hash_types =3D 0, rss_reta =3D 0x0, rss_key =3D 0x0,

    req_guest_features =3D 9223372445160806441, cvq =3D 0x0, use_va =3D tru=
e},
backend_type =3D VIRTIO_USER_BACKEND_VHOST_KERNEL, is_server =3D false, cal=
lfds
=3D 0x6000396000c0, kickfds =3D 0x60005ff40880, mac_specified =3D 1,
max_queue_pairs =3D 1,

  queue_pairs =3D 1, queue_size =3D 2048, features =3D 4563441697,
device_features =3D 4563442051, frontend_features =3D 32, unsupported_featu=
res
=3D 17293822186582074972, status =3D 15 '\017', net_status =3D 0, mac_addr =
=3D
"\000PV\235#g",

  path =3D "/dev/vhost-net", '\000' <repeats 4081 times>, ifname =3D
0x558185a04b70 "avi_eth1", vrings =3D {ptr =3D 0x60005ff40780, split =3D
0x60005ff40780, packed =3D 0x60005ff40780}, packed_queues =3D 0x0, qp_enabl=
ed =3D
0x60005ff406c0,

  ops =3D 0x55818218cc80 <virtio_ops_kernel>, mutex =3D {__data =3D {__lock=
 =3D 0,
__count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D 0, __spins =3D 0, =
__elision
=3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}}, __size =3D '\000' <rep=
eats 39
times>,

    __align =3D 0}, started =3D true, hw_cvq =3D false, scvq =3D 0x0, backe=
nd_data
=3D 0x558185a96100, notify_area =3D 0x0}



Workaround

If we explicitly insert the VLAN tag into the packet data (i.e., inline
VLAN insertion), the TAP interface sees the tag as expected, and the packet
is correctly forwarded to the intended sub-interface.
Conclusion

It appears that the VLAN offload flag and vlan_tci are not being honored or
processed correctly somewhere in the virtio path with vhost-net backend.
This leads to silent drops on the host kernel side due to missing VLAN tags=
.
Request

Could you please confirm if this is a known limitation or a bug? If it=E2=
=80=99s
the latter, I=E2=80=99d be happy to provide more debug info or steps to rep=
roduce.


Thanks,
Samar Yadav
Broadcom

--00000000000094a373063bb1faed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi all/Maxime/Chenbox,</p>
<p>I=E2=80=99m observing an issue with <code>virtio_user</code> (with <code=
>vhost-net</code> backend) where VLAN offload doesn&#39;t seem to insert th=
e VLAN tag, even though both <code>vlan_tci</code> and <code>ol_flags</code=
> are set correctly in the mbuf. We are using=C2=A0DPDK Version: 24.11 (cus=
tom build) and virtio_user for exception path traffic.</p>
<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><h3>Context=
</h3></blockquote>
<ul>
<li>
<p><strong>Scenario</strong>: When a packet with <code>vlan_tci</code> set =
is transmitted via <code>virtio_user</code> with <code>RTE_ETH_TX_OFFLOAD_V=
LAN_INSERT</code> enabled, the packet received on the parent TAP interface =
lacks the VLAN tag. It subsequently gets dropped, since it was meant for th=
e TAP sub-interface corresponding to the VLAN.</p>
</li>
<li>
<p><strong>Expected</strong>: The packet should carry the VLAN tag when see=
n on the TAP interface, allowing it to be delivered to the correct sub-inte=
rface.</p>
</li>
</ul>
<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><h3>Observa=
tions</h3></blockquote>
<ul>
<li>
<p>At the point of calling <code>virtio_xmit_pkts()</code>:</p>
<ul>
<li>
<p><code>vlan_tci</code> is correctly set (e.g., 61).</p>
</li>
<li>
<p><code>ol_flags</code> contains <code>RTE_MBUF_F_TX_VLAN</code> (bit 0) =
=3D&gt; value =3D 0x1.</p>
</li>
</ul>
</li>
<li>
<p>We confirmed the following in GDB just before calling <code>virtqueue_en=
queue_xmit()</code>:</p></li></ul><blockquote style=3D"margin:0 0 0 40px;bo=
rder:none;padding:0px"><blockquote style=3D"margin:0 0 0 40px;border:none;p=
adding:0px"><div>(gdb) p **tx_pkts</div></blockquote><blockquote style=3D"m=
argin:0 0 0 40px;border:none;padding:0px"><div>$6 =3D { ..., vlan_tci =3D 6=
1, ..., ol_flags =3D 65, ... }</div></blockquote><blockquote style=3D"margi=
n:0 0 0 40px;border:none;padding:0px"><div>(gdb) p /t tx_pkts.ol_flags</div=
></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0p=
x"><div>$8 =3D 1000001</div></blockquote></blockquote><blockquote style=3D"=
margin:0 0 0 40px;border:none;padding:0px"><div><br></div></blockquote><blo=
ckquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>The value =
<code>65</code> (<code>0b1000001</code>) confirms that=C2=A0<code>RTE_ETH_T=
X_OFFLOAD_VLAN_INSERT=C2=A0(bit 0)</code>=C2=A0is=C2=A0set.<br>Despite this=
, the packet captured on the TAP interface is a plain Ethernet frame, with =
no VLAN tag.<br></div><div><br></div></blockquote><blockquote style=3D"marg=
in:0 0 0 40px;border:none;padding:0px"><div>Adding few more outputs more gd=
b</div><div><br></div></blockquote><blockquote style=3D"margin:0 0 0 40px;b=
order:none;padding:0px"><blockquote style=3D"margin:0 0 0 40px;border:none;=
padding:0px"><div>(gdb) p rte_eth_devices[33]</div></blockquote><blockquote=
 style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>$4 =3D {rx_pkt_bu=
rst =3D 0x558180950c36 &lt;virtio_recv_mergeable_pkts&gt;, tx_pkt_burst =3D=
 0x558180952440 &lt;virtio_xmit_pkts&gt;, tx_pkt_prepare =3D 0x558180951fa3=
 &lt;virtio_xmit_pkts_prepare&gt;, rx_queue_count =3D 0x0, rx_descriptor_st=
atus =3D 0x0,</div></blockquote><blockquote style=3D"margin:0 0 0 40px;bord=
er:none;padding:0px"><div>=C2=A0 tx_queue_count =3D 0x0, tx_descriptor_stat=
us =3D 0x0, recycle_tx_mbufs_reuse =3D 0x0, recycle_rx_descriptors_refill =
=3D 0x0, data =3D 0x60005fd8e080, process_private =3D 0x0, dev_ops =3D 0x55=
818211e2a0 &lt;virtio_eth_dev_ops&gt;,</div></blockquote><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 flow_fp_ops =3D =
0x55818218d140 &lt;rte_flow_fp_default_ops&gt;, device =3D 0x558185a960b0, =
intr_handle =3D 0x558185a96160, link_intr_cbs =3D {tqh_first =3D 0x0, tqh_l=
ast =3D 0x5581825a42f8 &lt;rte_eth_devices+547128&gt;}, post_rx_burst_cbs =
=3D {</div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;=
padding:0px"><div>=C2=A0 =C2=A0 0x0 &lt;repeats 1024 times&gt;}, pre_tx_bur=
st_cbs =3D {0x0 &lt;repeats 1024 times&gt;}, state =3D RTE_ETH_DEV_ATTACHED=
, security_ctx =3D 0x0}</div></blockquote></blockquote><blockquote style=3D=
"margin:0 0 0 40px;border:none;padding:0px"><blockquote style=3D"margin:0 0=
 0 40px;border:none;padding:0px"><div><br></div></blockquote><blockquote st=
yle=3D"margin:0 0 0 40px;border:none;padding:0px"><div>(gdb) p *rte_eth_dev=
ices[33].data</div></blockquote><blockquote style=3D"margin:0 0 0 40px;bord=
er:none;padding:0px"><div>$6 =3D {name =3D &quot;virtio_user0&quot;, &#39;\=
000&#39; &lt;repeats 51 times&gt;, rx_queues =3D 0x60005fc2ef80, tx_queues =
=3D 0x60005fc2cf00, nb_rx_queues =3D 1, nb_tx_queues =3D 1, sriov =3D {acti=
ve =3D 0 &#39;\000&#39;, nb_q_per_pool =3D 0 &#39;\000&#39;, def_vmdq_idx =
=3D 0, def_pool_q_idx =3D 0},</div></blockquote><blockquote style=3D"margin=
:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 dev_private =3D 0x60005fc6=
0380, dev_link =3D {{val64 =3D 34359738367, {link_speed =3D 4294967295, lin=
k_duplex =3D 1, link_autoneg =3D 1, link_status =3D 1}}}, dev_conf =3D {lin=
k_speeds =3D 0, rxmode =3D {mq_mode =3D RTE_ETH_MQ_RX_NONE, mtu =3D 9000,</=
div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding=
:0px"><div>=C2=A0 =C2=A0 =C2=A0 max_lro_pkt_size =3D 0, offloads =3D 8193, =
reserved_64s =3D {0, 0}, reserved_ptrs =3D {0x0, 0x0}}, txmode =3D {mq_mode=
 =3D RTE_ETH_MQ_TX_NONE, offloads =3D 32813, pvid =3D 0, hw_vlan_reject_tag=
ged =3D 0 &#39;\000&#39;, hw_vlan_reject_untagged =3D 0 &#39;\000&#39;,</di=
v></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0=
px"><div>=C2=A0 =C2=A0 =C2=A0 hw_vlan_insert_pvid =3D 0 &#39;\000&#39;, res=
erved_64s =3D {0, 0}, reserved_ptrs =3D {0x0, 0x0}}, lpbk_mode =3D 0, rx_ad=
v_conf =3D {rss_conf =3D {rss_key =3D 0x0, rss_key_len =3D 0 &#39;\000&#39;=
, rss_hf =3D 0, algorithm =3D RTE_ETH_HASH_FUNCTION_DEFAULT},</div></blockq=
uote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=
=C2=A0 =C2=A0 =C2=A0 vmdq_dcb_conf =3D {nb_queue_pools =3D 0, enable_defaul=
t_pool =3D 0 &#39;\000&#39;, default_pool =3D 0 &#39;\000&#39;, nb_pool_map=
s =3D 0 &#39;\000&#39;, pool_map =3D {{vlan_id =3D 0, pools =3D 0} &lt;repe=
ats 64 times&gt;}, dcb_tc =3D &quot;\000\000\000\000\000\000\000&quot;}, dc=
b_rx_conf =3D {</div></blockquote><blockquote style=3D"margin:0 0 0 40px;bo=
rder:none;padding:0px"><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_tcs =3D 0, dcb_t=
c =3D &quot;\000\000\000\000\000\000\000&quot;}, vmdq_rx_conf =3D {nb_queue=
_pools =3D 0, enable_default_pool =3D 0 &#39;\000&#39;, default_pool =3D 0 =
&#39;\000&#39;, enable_loop_back =3D 0 &#39;\000&#39;, nb_pool_maps =3D 0 &=
#39;\000&#39;, rx_mode =3D 0, pool_map =3D {{</div></blockquote><blockquote=
 style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 vlan_id =3D 0, pools =3D 0} &lt;repeats 64 times&g=
t;}}}, tx_adv_conf =3D {vmdq_dcb_tx_conf =3D {nb_queue_pools =3D 0, dcb_tc =
=3D &quot;\000\000\000\000\000\000\000&quot;}, dcb_tx_conf =3D {nb_tcs =3D =
0, dcb_tc =3D &quot;\000\000\000\000\000\000\000&quot;}, vmdq_tx_conf =3D {=
</div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;paddi=
ng:0px"><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_queue_pools =3D 0}}, dcb_capabi=
lity_en =3D 0, intr_conf =3D {lsc =3D 0, rxq =3D 0, rmv =3D 0}}, mtu =3D 90=
00, min_rx_buf_size =3D 4294967295, rx_mbuf_alloc_failed =3D 0, mac_addrs =
=3D 0x60005ff404c0, mac_pool_sel =3D {0 &lt;repeats 128 times&gt;},</div></=
blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px">=
<div>=C2=A0 hash_mac_addrs =3D 0x0, port_id =3D 33, promiscuous =3D 0 &#39;=
\000&#39;, scattered_rx =3D 0 &#39;\000&#39;, all_multicast =3D 0 &#39;\000=
&#39;, dev_started =3D 1 &#39;\001&#39;, lro =3D 0 &#39;\000&#39;, dev_conf=
igured =3D 1 &#39;\001&#39;, flow_configured =3D 0 &#39;\000&#39;,</div></b=
lockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><=
div>=C2=A0 rx_queue_state =3D &quot;\001&quot;, &#39;\000&#39; &lt;repeats =
1022 times&gt;, tx_queue_state =3D &quot;\001&quot;, &#39;\000&#39; &lt;rep=
eats 1022 times&gt;, dev_flags =3D 0, numa_node =3D -1, vlan_filter_conf =
=3D {ids =3D {0 &lt;repeats 64 times&gt;}}, owner =3D {id =3D 0,</div></blo=
ckquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><di=
v>=C2=A0 =C2=A0 name =3D &#39;\000&#39; &lt;repeats 63 times&gt;}, represen=
tor_id =3D 0, backer_port_id =3D 64, flow_ops_mutex =3D {__data =3D {__lock=
 =3D 0, __count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D 0, __spins=
 =3D 0, __elision =3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}},</div=
></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0p=
x"><div>=C2=A0 =C2=A0 __size =3D &#39;\000&#39; &lt;repeats 39 times&gt;, _=
_align =3D 0}}</div></blockquote><blockquote style=3D"margin:0 0 0 40px;bor=
der:none;padding:0px"><div><br></div></blockquote><blockquote style=3D"marg=
in:0 0 0 40px;border:none;padding:0px"><div>(gdb) p *(struct virtio_user_de=
v*)rte_eth_devices[33].data.dev_private</div></blockquote><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div>$3 =3D {hw =3D {vqs =3D=
 0x60005ff40400, guest_features =3D 4563441697, vtnet_hdr_size =3D 12, star=
ted =3D 1 &#39;\001&#39;, weak_barriers =3D 1 &#39;\001&#39;, vlan_strip =
=3D 1 &#39;\001&#39;, rx_ol_scatter =3D true, has_tx_offload =3D 1 &#39;\00=
1&#39;, has_rx_offload =3D 0 &#39;\000&#39;,</div></blockquote><blockquote =
style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 =C2=A0 use_=
vec_rx =3D 0 &#39;\000&#39;, use_vec_tx =3D 0 &#39;\000&#39;, use_inorder_r=
x =3D 0 &#39;\000&#39;, use_inorder_tx =3D 0 &#39;\000&#39;, opened =3D 1 &=
#39;\001&#39;, port_id =3D 33, mac_addr =3D &quot;\000PV\235#g&quot;, get_s=
peed_via_feat =3D false, speed =3D 4294967295, duplex =3D 1 &#39;\001&#39;,=
</div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;paddi=
ng:0px"><div>=C2=A0 =C2=A0 intr_lsc =3D 1 &#39;\001&#39;, max_mtu =3D 9698,=
 max_rx_pkt_len =3D 9030, state_lock =3D {locked =3D 0}, inject_pkts =3D 0x=
0, max_queue_pairs =3D 1, rss_rx_queues =3D 0, rss_hash_types =3D 0, rss_re=
ta =3D 0x0, rss_key =3D 0x0,</div></blockquote><blockquote style=3D"margin:=
0 0 0 40px;border:none;padding:0px"><div>=C2=A0 =C2=A0 req_guest_features =
=3D 9223372445160806441, cvq =3D 0x0, use_va =3D true}, backend_type =3D VI=
RTIO_USER_BACKEND_VHOST_KERNEL, is_server =3D false, callfds =3D 0x60003960=
00c0, kickfds =3D 0x60005ff40880, mac_specified =3D 1, max_queue_pairs =3D =
1,</div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;pad=
ding:0px"><div>=C2=A0 queue_pairs =3D 1, queue_size =3D 2048, features =3D =
4563441697, device_features =3D 4563442051, frontend_features =3D 32, unsup=
ported_features =3D 17293822186582074972, status =3D 15 &#39;\017&#39;, net=
_status =3D 0, mac_addr =3D &quot;\000PV\235#g&quot;,</div></blockquote><bl=
ockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 pa=
th =3D &quot;/dev/vhost-net&quot;, &#39;\000&#39; &lt;repeats 4081 times&gt=
;, ifname =3D 0x558185a04b70 &quot;avi_eth1&quot;, vrings =3D {ptr =3D 0x60=
005ff40780, split =3D 0x60005ff40780, packed =3D 0x60005ff40780}, packed_qu=
eues =3D 0x0, qp_enabled =3D 0x60005ff406c0,</div></blockquote><blockquote =
style=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 ops =3D 0x5=
5818218cc80 &lt;virtio_ops_kernel&gt;, mutex =3D {__data =3D {__lock =3D 0,=
 __count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D 0, __spins =3D 0,=
 __elision =3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}}, __size =3D =
&#39;\000&#39; &lt;repeats 39 times&gt;,</div></blockquote><blockquote styl=
e=3D"margin:0 0 0 40px;border:none;padding:0px"><div>=C2=A0 =C2=A0 __align =
=3D 0}, started =3D true, hw_cvq =3D false, scvq =3D 0x0, backend_data =3D =
0x558185a96100, notify_area =3D 0x0}</div></blockquote></blockquote><blockq=
uote style=3D"margin:0 0 0 40px;border:none;padding:0px"><ul>
</ul>
<h3>Workaround</h3>
<p>If we explicitly insert the VLAN tag into the packet data (i.e., inline =
VLAN insertion), the TAP interface sees the tag as expected, and the packet=
 is correctly forwarded to the intended sub-interface.</p>
<h3>Conclusion</h3>
<p>It appears that the VLAN offload flag and <code>vlan_tci</code> are not =
being honored or processed correctly somewhere in the virtio path with <cod=
e>vhost-net</code> backend. This leads to silent drops on the host kernel s=
ide due to missing VLAN tags.</p>
<h3>Request</h3>
<p>Could you please confirm if this is a known limitation or a bug? If it=
=E2=80=99s the latter, I=E2=80=99d be happy to provide more debug info or s=
teps to reproduce.</p><p><br></p><p>Thanks,<br>
Samar Yadav<br>
Broadcom<br></p></blockquote></div>

--00000000000094a373063bb1faed--

--000000000000a7f6b5063bb1fa8b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kja/g2szBOE3duK0S2F2779B8HXwveUyzPgAwjVYEH44E7DH9DQmwQq+FwsfENCP+foBnvorv2z8
U7iSJ1MzZO+vW9LFumoj1eXi5cE8z2Ea1L0ByfljUVo42AV0h/Ya+TUjnYnsth0I1YZIT2PSxYHA
AEfkZEgeq9I7uOMhQkIMCs02pRLMqiWsNLyuvH/pUIbBw6LpvokCAwEAAaOCAdkwggHVMA4GA1Ud
DwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGG
LWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBc
MAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNVHR8EOjA4
MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmww
IwYDVR0RBBwwGoEYc2FtYXIueWFkYXZAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvmSXDCB/ccXsgukGM
sX5tz+yvpjANBgkqhkiG9w0BAQsFAAOCAgEAVqFL/K4aJKnBFwT4nNKkTxk+cBUjXSFfDozeSZ9b
g3ThFbkFjAtktwQ52s8i8GX3pTK/HnQHE7/1NwPk53A+8RMFzBf+wvw+S1QUGDVc7RGIEzmUdNbz
/ZRBwJ4whMX7/fieBaJDB+JwLimr8WnxFQGeg7/4rI3hyrUf5iR0541F5ADx2zKHOjz2tOBaft5Q
jD7uJD/TCk8EB3v8eAt5Icl0odYbKttnOSiiqyOHbiSylSoR+mzn/Rpdj+eihkDx7A/w/53oNPVu
DxZTK6Jugi9ee5fgHe9hw2RAt+G/TuKPDaM/G7q5UGqNAjfXPD26gxpKnttvt6aVZpCUyG7AIzdS
nZrOUMvSb4HWIVLsmGd8WD6ocOfku5rV3Bp/UiXf8ZWWX1LLn6czGNjAH2+5CaeSr8ekEsJeAxD8
Kv7PgwcSfP7dL1j39xnxMyG0i3G91WA16ElBqrkRNZ0ZEdhUVxqI6/NGDFRG1JAhgqtZbVtFNB3r
MlnlHxUjm0A5qQetwM53ESIGkCanuyB+BU0sUT3M2A0+OvrfTykrJOVTm9yDM6fdpRdFemiFlZff
//q+ze6T+s7vikhZo7kdvgqCVZlebVA5Bu0q1wQbmT8WGg7auMfMX+KILF2LOQEuMUDvzh6i9qSo
9PWqQlOnZjQGJrO/squd6m7/55VCqPimYV4xggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgxHIVdTtRDtl2xGE6EwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IKdBfChCpOj6VOx9FqqPSU/urOSZy+ecBpq8VCYb5yWJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgwNjEzMDQyMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKbMw/OFHjin/K96H/AZvRs909oM64+KHZ6L
Tgj/F+xfKzZ+o2OltWZYIZgmZzWOV64b4ElaNJ+BnVNu8lS2sJMlS4MMSsnnfgZ9TiRLHrI1sg0s
2LAm70Uc1iZV1GLKYvTVOuR/AS1/W01SD3CXhUXwjf5z1gKn+EvehtgbgPwfJFUYmHUn7Cl2vhpb
NADhnXblEv2wO2A9my0l7/bS1dHy2/K0v99BiKJWxnwdOecibznUHzX+eCy4eXtnYxAVRaWVFDwc
AeKPUY/mf2o0Vvbq93a0v/H03d+UJ+DkLNPg0DjsYxeh5z2L3dcxjlnsV17sEFFVqNslBIm1xayK
pm4=
--000000000000a7f6b5063bb1fa8b--
