Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10372C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 18:28:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9BCC40279;
	Thu, 13 Feb 2025 19:28:38 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 553EE40263
 for <dev@dpdk.org>; Thu, 13 Feb 2025 19:28:37 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so1821928a91.2
 for <dev@dpdk.org>; Thu, 13 Feb 2025 10:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739471316;
 x=1740076116; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkrIaEXg1eZG+wosIt6JqkoQqkG6dvL1JD1IlYtc7NA=;
 b=HwXmuvZq0j+SeXOBPnPckD4QGS8R/CSZlJ80bwKZN07vGqHB5l11WB5XUaSt2dIkTS
 PljBXHyTvmZ6/uWEaoSwOi+Am/mGvmz/JXhGJ308q/ErVFx9TkkrFZUso/o85HgRTsWY
 UQs1Q6rxCNE3Kb/xpE1aIJDbkG+iis1NZJN6xXV3PX4RbD95nIpN631yjcmx3Xf5kKJr
 bHIi4sySJU6BWr0optx+Hq1a+/09sqwxid2YtkmkLHPkKhphPiV7hxTMs/l9RQ9yPq/e
 0Du1c3SIMRn6cnhMR0HV9dfpAjOfx0H8SwlSDr2K2inAthXyINUjx26eAvODiCp51m/i
 BGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739471316; x=1740076116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkrIaEXg1eZG+wosIt6JqkoQqkG6dvL1JD1IlYtc7NA=;
 b=YQTZGd4M1YvQHtlbqJFjbYbsVlIUgEYMeb6jAgnN3Epcf6SdQoXs+AXoZc8YI09ydr
 ekiRhfKRzI5rcOH9ZhZ83oYPUZQypNswv8IA1ML1n3f+8WPgXoZPYw8FhetkMuj1fjYA
 aiNCiH3p6atRHMqRr4v6sK8Cf/Az56gOU7NlAqJs6Js+Chsq0bUQDIfe4e4YCmQ/6tv9
 yJKyZ7g03j/Ko5SRg4c2GiD5IZU8lCC9OjvP3KFGdJHX79DC+ve8yaVPnnKd9lqCf2E5
 8M6wVb2U00cRoNG+fujS55SzZhccRfhzvXCYNImnYKJ5VT73yNNLUrAn1jh5cg5TY1tG
 6h7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNvJ0nGvl7vj3sxNNfFjUD/7lpijARufgYI2UDazXCBINvWuIt6kHm5KpZAeb8f20/Src=@dpdk.org
X-Gm-Message-State: AOJu0Yysa5OHcP7yy6dQ7MKpCbGLoXhREZ3GttbLJeaHdCZo1A6GcXe6
 P3V7ek1N6PkRzfRWNAlYiix16m3OJyemcREWO2hriZsItFw8uQ/8P27hF51mhpU=
X-Gm-Gg: ASbGncsOKF7TvXZbZL0KXTVq6HCrxMAkrl64bubqxpLUjR8QcBSfCP/Y+faHrLa8Kt8
 eM08E5jUG9zrWHkxzFWGCXA98/ErL90Qr7V1s4EaKh9q3Pt86CiBTGPmcutt7U6ieu0Y4MiQSX+
 Dzm4iYRZ8XKh5Q/xa1kpajnLnGv7NWf8kLkDWBPD+FRc96HLh4vkWcclwzVIiP8SYKVWzuWPByp
 WrK2QkC2aMjehZdt9HnCdpz91GHdFdke5+V3YgDbT0rrENe3XJsnPzBjUmU3bjJMaM9g56YjbTO
 fh77xCPDMETuFXK1RbTE8Wy4myO8z26K7VJyQspcyLnLLRoMYKYybLn23CSYVn9KXXEO
X-Google-Smtp-Source: AGHT+IEBLuKMHV4/GSTQ4U6Pe6Lpj/dAkqK45zXa6AvYihAKjpXn5jqEdjPorygWf+4jEY/BPn1JDQ==
X-Received: by 2002:a17:90b:3c8b:b0:2ee:c2df:5d30 with SMTP id
 98e67ed59e1d1-2fc0f0b0856mr5489729a91.26.1739471316365; 
 Thu, 13 Feb 2025 10:28:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d3a6sm15226685ad.160.2025.02.13.10.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 10:28:35 -0800 (PST)
Date: Thu, 13 Feb 2025 10:28:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v12 00/28] [v12]drivers/net Add Support mucse N10 Pmd
 Driver
Message-ID: <20250213102833.12f6399d@hermes.local>
In-Reply-To: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
References: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 12 Feb 2025 23:32:20 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso=20
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
>=20
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.

The driver is getting very close to being ready to merge but still see
some things. Mostly the issues are around the documentation now.

Review checklist for rnp v12 patches:

Mark items with:
    =E2=9C=94 passed
    =E2=9C=98 Failed

Basic hygiene
    =E2=9C=94 Look at CI results in patchwork
    =E2=9C=94 Merge cleanly with git am; look for missing newline at EOF etc
    =E2=9C=98 Run checkpatches; warnings are ok, but look more carefully.
      Lots of warnings from base code (allowed but not preferred).

Fix these by making it an inline function?

#1143: FILE: drivers/net/rnp/rnp.h:62:
+#define RNP_PF_OWN_PORTS(id)	(((id) =3D=3D 0) ? 1 : (((id) =3D=3D 1) ? 2 :=
 4))

+#define RNP_LINK_SPEED_CODE(sp, n) \
+	(((sp) & RTE_GENMASK32((11) + ((4) * (n)), \
+		(8) + ((4) * (n)))) >> (8 + 4 * (n)))

This warning could be fixed with either a temporary variable or longer line

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'rt=
e_eth_devices[rxq->attr.port_id].data->rx_mbuf_alloc_failed'
#63: FILE: drivers/net/rnp/rnp_rxtx.c:849:
+			rte_eth_devices[rxq->attr.port_id].data->
+				rx_mbuf_alloc_failed++;


    =E2=9C=94 Run check-git-log
    =E2=9C=94 Run check-symbol-maps.sh
    =E2=9C=94 Run check-doc-vs-code
    =E2=9C=94 Run check-spdk-tag

Builds
    =E2=9C=94 Normal Gcc build
    =E2=9C=94 Use latest experimental Gcc 15 to catch new warnings
    =E2=9C=94 Clang build using current version (clang-19)
    =E2=9C=94 Build for 32 bit x86
    =E2=9C=94 Doc build; works but needs editing
The wording in rnp.rst is not grammatically correct.
Missing articles and some punctuation issues.
Need to mention big-endian limitations.
Windows limitation not mentioned.
Suggest using svg diagram (looks better) rather than ASCII art.

    =E2=9C=98 Check feature matrix versus code
The driver doc says it supports queue start/stop but no
rx_queue_start or tx_queue_start operations are listed.

    =E2=9C=94 Debug build
    =E2=9C=94 Enable asserts
    =E2=9C=94 Test meson builds

Experimental builds:
     Enable address sanitizer
     =E2=9C=98 Enable extra warnings (edit meson.build) for
        -Wvla, -Wformat-truncation, -Waddress-of-packed-member

     The issue here is that name is limited to RTE_ETH_NAME_MAX_LEN
     and hw->device_name is RTE_DEV_NAME_MAX_LEN is also 64
     so adding a suffix could potentially overflow the name.

     One way to avoid compiler warning is a a check on length of
     hw->device_name in this code like:
        if (strlen(hw->device_name) + 4 > sizeof(name))
	   return -EINVAL


../drivers/net/rnp/rnp_ethdev.c: In function =E2=80=98rnp_eth_dev_init=E2=
=80=99:
../drivers/net/rnp/rnp_ethdev.c:1705:45: warning: =E2=80=98%d=E2=80=99 dire=
ctive output may be truncated writing 1 byte into a region of size between =
0 and 63 [-Wformat-truncation=3D]
 1705 |                                         "%s_%d", hw->device_name, p=
_id);
      |                                             ^~
../drivers/net/rnp/rnp_ethdev.c:1705:41: note: directive argument in the ra=
nge [1, 4]
 1705 |                                         "%s_%d", hw->device_name, p=
_id);
      |                                         ^~~~~~~
../drivers/net/rnp/rnp_ethdev.c:1704:25: note: =E2=80=98snprintf=E2=80=99 o=
utput between 3 and 66 bytes into a destination of size 64
 1704 |                         snprintf(name, sizeof(name),
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1705 |                                         "%s_%d", hw->device_name, p=
_id);
      |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~

Look for anti-patterns:
    =E2=9C=94 Driver must not disable warnings with compiler flags or pragm=
a's
    =E2=9C=94 Driver must not use thread and signal
    =E2=9C=94 Apply coccinelle scripts; look that for example null free che=
cks
    =E2=9C=94 Review use of memcpy/rte_memcpy
    =E2=9C=94 Review use of malloc
    =E2=9C=94 Review locking
    =E2=9C=98 Review use of memset
      Use of memset before snprintf is unnecessary.

    =E2=9C=98 Handling of deferred start
      If driver supports deferred start then it has to have a
      queue start/stop operation. Otherwise ignore the flag.

    =E2=9C=98 Review whitespace
      Unneeded indents in meson.build

sources =3D files(
                'rnp_ethdev.c',
...
vs.
sources =3D files(
        'ixgbe_82599_bypass.c',
...

Other
1. The xstat names are long and have spaces in them.
   I don't see this in other drivers.
   Suggest using similar naming pattern as virtio

2. Handling of queue counters
   This code would look much cleaner with temp variable.
   No need for useless init of i. and it is unsigned.
   Don't need to cast void * pointer

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index a295982780..1305d7e0dc 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1254,48 +1254,36 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 	struct rnp_eth_port *port =3D RNP_DEV_TO_PORT(dev);
 	struct rnp_hw_eth_stats *eth_stats =3D &port->eth_stats;
 	struct rte_eth_dev_data *data =3D dev->data;
-	int i =3D 0;
+	uint16_t i;

 	PMD_INIT_FUNC_TRACE();
 	rnp_get_hw_stats(dev);
+
 	for (i =3D 0; i < data->nb_rx_queues; i++) {
-		if (!data->rx_queues[i])
+		const struct rnp_rx_queue *rxq =3D dev->data->rx_queues[i];
+		if (!rxq)
 			continue;
+
+		stats->ipackets +=3D rxq->stats.ipackets;
+		stats->ibytes +=3D rxq->stats.ibytes;
 		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] =3D ((struct rnp_rx_queue **)
-					(data->rx_queues))[i]->stats.ipackets;
-			stats->q_ibytes[i] =3D ((struct rnp_rx_queue **)
-					(data->rx_queues))[i]->stats.ibytes;
-			stats->ipackets +=3D stats->q_ipackets[i];
-			stats->ibytes +=3D stats->q_ibytes[i];
-		} else {
-			stats->ipackets +=3D ((struct rnp_rx_queue **)
-					(data->rx_queues))[i]->stats.ipackets;
-			stats->ibytes +=3D ((struct rnp_rx_queue **)
-					(data->rx_queues))[i]->stats.ibytes;
+			stats->q_ipackets[i] =3D rxq->stats.ipackets;
+			stats->q_ibytes[i] =3D rxq->stats.ibytes;
 		}
 	}

 	for (i =3D 0; i < data->nb_tx_queues; i++) {
-		if (!data->tx_queues[i])
+		const struct rnp_tx_queue *txq =3D dev->data->tx_queues[i];
+		if (!txq)
 			continue;
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] =3D ((struct rnp_tx_queue **)
-					(data->tx_queues))[i]->stats.opackets;
-			stats->q_obytes[i] =3D ((struct rnp_tx_queue **)
-					(data->tx_queues))[i]->stats.obytes;
-			stats->oerrors +=3D ((struct rnp_tx_queue **)
-					(data->tx_queues))[i]->stats.errors;
-			stats->opackets +=3D stats->q_opackets[i];
-			stats->obytes +=3D stats->q_obytes[i];

-		} else {
-			stats->opackets +=3D ((struct rnp_tx_queue **)
-					(data->tx_queues))[i]->stats.opackets;
-			stats->obytes +=3D ((struct rnp_tx_queue **)
-					(data->tx_queues))[i]->stats.obytes;
-			stats->oerrors +=3D ((struct rnp_tx_queue **)
-					(data->tx_queues))[i]->stats.errors;
+		stats->opackets +=3D txq->stats.opackets;
+		stats->obytes +=3D txq->stats.obytes;
+		stats->oerrors +=3D txq->stats.errors;
+
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] =3D txq->stats.opackets;
+			stats->q_obytes[i] =3D txq->stats.obytes;
 		}
 	}
 	stats->imissed =3D eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
@@ -1308,22 +1296,18 @@ rnp_dev_stats_reset(struct rte_eth_dev *dev)
 {
 	struct rnp_eth_port *port =3D RNP_DEV_TO_PORT(dev);
 	struct rnp_hw_eth_stats *eth_stats =3D &port->eth_stats;
-	struct rnp_rx_queue *rxq;
-	struct rnp_tx_queue *txq;
 	uint16_t idx;

 	PMD_INIT_FUNC_TRACE();
 	memset(eth_stats, 0, sizeof(*eth_stats));
 	for (idx =3D 0; idx < dev->data->nb_rx_queues; idx++) {
-		rxq =3D ((struct rnp_rx_queue **)
-				(dev->data->rx_queues))[idx];
+		struct rnp_rx_queue *rxq =3D dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		memset(&rxq->stats, 0, sizeof(struct rnp_queue_stats));
 	}
 	for (idx =3D 0; idx < dev->data->nb_tx_queues; idx++) {
-		txq =3D ((struct rnp_tx_queue **)
-				(dev->data->tx_queues))[idx];
+		struct rnp_tx_queue *txq =3D dev->data->tx_queues[idx];
 		if (!txq)
 			continue;
 		memset(&txq->stats, 0, sizeof(struct rnp_queue_stats));

