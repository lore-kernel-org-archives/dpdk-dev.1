Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D389DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 15:07:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFFEF402E7;
	Mon, 14 Jul 2025 17:07:05 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id C68E4400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 17:07:03 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so38114646d6.3
 for <dev@dpdk.org>; Mon, 14 Jul 2025 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752505623;
 x=1753110423; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzYtxuAC5Hej7BKblKyqN4kq9oesD5t1Xa0i7nc4HPY=;
 b=qkJf5RynaHq9ARN5v5pkcQMcVqkDxw8xp97UJFx4BNqxpbny5kw6khTb3Ep8W1Ywzm
 CunKgZINumJkPgbwGsQIx2xhpQ/8rqkrYGYVf1Y0Q0l0mgeNH1JeQ/dX8g099A5D1rCT
 nWbNyiW0pbn5mt+ZlqKWn++naN7rmNy9qAVHX6TPq3/WLZ/VJxWMdMrXqBclRC6GW9OW
 BZEfYU0OORNwHgKOjntqr9l5XUfa4hEk8vDphDeMUMJlqXn8pzCm7IqMwn00f2a7aCru
 cHNB7Mx2vtqCq20yFok/ONV5JYs7teFJ9GuRo3cBa1IM4bie5QueRHHw4l/2SYpCodW8
 jEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752505623; x=1753110423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzYtxuAC5Hej7BKblKyqN4kq9oesD5t1Xa0i7nc4HPY=;
 b=jFnbq2gXbCoaHKr54nbtNgfex/wV8GOXiG5w7gtNqOFW/bWyfqOaoFpiZ7rX8Zg+fj
 DEAKnK89MBNguGirssFgT4HGjDb+AgtMowJMGUZCsBIciMICvxPZjVDUaRdNeoHFi7qg
 UIMNoFwgCj+Ujg3XCQbqHvSh6oHLD/iqzB/MVFXbrgn9Z2LExZoFDqtfE8I8nikKB9SU
 JFkCMTB7x3Ac2F6qi0ewvs+f5UHHyPhyCrlbhITo8IzH+NiB7LFLXKJTrMov5AA5ehyY
 prTOLrvA0C+3nU+O7cfe72KHpotTokkdSWHRA6Mn/dfCf9T1XWptjem/ghIYt8XRQVpO
 weWA==
X-Gm-Message-State: AOJu0YxuGeyq3n7Lp2ibP4ySWVkuQNlD7CS0v5li+rawdtWnsrJ5qRY1
 CLo4YbM/+04dgtgW/NU9ouZgXYhEkhfIO4iTwNQQwYypimdJ7QT9FxoFV1FmB41IUtM=
X-Gm-Gg: ASbGncv9Tfq1QQzi/BsQ9RByJ7klmJ94/G1qhi/CKNntw6Bvo+RzcPW8QKZg4igtA3p
 fcatyA6/SuHgqBCSjmWXHcKbtUf8aNuPOiV1bhcRaOEiCh+vTL8KyPxi8QSusMhBxIpTHq8/Cm1
 4HMlg3FSgow240YDEy1C3o9iQEFeYjrf3o5chDVRwovCTxlJLJibQaPkAOcCc6JY3Dx8K7TIS+B
 khYG4WWHWqBhX7o9vWa4fN5lnUHCCu2p/lcX9/IWAyr+Nxe2XwvguvRzT593ZdmBxh2zyh/1VSQ
 hHvDI887oliZbAw52AjqcfIToJSoygRm1+GugLzzCoL2ZMjt2FVWT6ZWAvLbOr1r76GJKNJWvl3
 If9mOtKspXeQ5Ny1mivbN/v3GpjvUJQUIzXseBlH0uqIHcAIVl/5cogKcdpyVWtqCbTIazhr/UB
 U=
X-Google-Smtp-Source: AGHT+IFh2eHRcepaTUmx7RV7tyzBGoZxMP/oODzQzJfPs7DgjezckVpjN+PIkV7S6G5vM3lC3WuV2A==
X-Received: by 2002:ad4:5b88:0:b0:701:78e:333 with SMTP id
 6a1803df08f44-704a4325033mr231268446d6.34.1752505618217; 
 Mon, 14 Jul 2025 08:06:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7049799e8a9sm47758956d6.10.2025.07.14.08.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:06:58 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:06:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, techboard@dpdk.org
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <20250714080654.3c1feeea@hermes.local>
In-Reply-To: <20250714133014.44597-1-bruce.richardson@intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 14 Jul 2025 14:30:14 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> not very well documented. Even the documentation that does exist appears
> contradictory.
> 
> For example, the doxygen docs for the mbuf flag
> RTE_MBUF_F_RX_QINQ_STRIPPED says:
> 
>   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
>   is unset, only the outer VLAN is removed from packet data,..."
> 
> but the docs for RTE_MBUF_F_RX_QINQ says:
> 
>   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
>   headers have been stripped from mbuf data, ..."
> 
> Without a good definition of what the correct behaviour is, it's not
> possible to assess and ensure conformance across drivers. Update the
> documentation for NIC features, ethdev and mbuf library to all report
> the same information: that VLAN strip feature is stripping one flag, and
> QinQ strip feature is removing two.
> 
> Summary of VLAN and QinQ stripping behaviour as reported in docs after
> this patch:
> 
> +-------------------+----------------------+----------------------------+
> | Input Traffic     | VLAN-strip on        | QinQ strip on              |
> +===================+======================+============================+
> | Single VLAN pkts  | Tag in vlan_tci      | Tag in vlan_tci            |
> +-------------------+----------------------+----------------------------+
> | Double VLAN pkts  | Outer tag in vlan_tci| Outer tag in vlan_tci_outer|
> |                   |                      | Inner tag in vlan_tci      |
> +-------------------+----------------------+----------------------------+
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/nics/features.rst | 21 +++++++++++++++++++++
>  lib/ethdev/rte_ethdev.h      | 20 ++++++++++++++++++++
>  lib/mbuf/rte_mbuf_core.h     | 36 ++++++++++++++++++++----------------
>  3 files changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
> index a075c057ec..c57ea8e08f 100644
> --- a/doc/guides/nics/features.rst
> +++ b/doc/guides/nics/features.rst
> @@ -483,6 +483,11 @@ VLAN offload
>  ------------
>  
>  Supports VLAN offload to hardware.
> +This includes both VLAN stripping on Rx and VLAN insertion on Tx.
> +
> +On Rx VLAN strip always strips one VLAN tag if available.
> +If multiple VLAN tags are present, it strips the outer tag.
> +The stripped VLAN TCI is saved in mbuf->vlan_tci.
>  
>  * **[uses]       rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_VLAN_STRIP,RTE_ETH_RX_OFFLOAD_VLAN_FILTER,RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``.
>  * **[uses]       rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_VLAN_INSERT``.
> @@ -501,6 +506,22 @@ QinQ offload
>  ------------
>  
>  Supports QinQ (queue in queue) offload.
> +This includes both QinQ stripping on Rx and QinQ insertion on Tx.
> +
> +On Rx, QinQ strip strips two VLAN tags if present.
> +If only one tag is present, it behaves as VLAN strip.
> +Specifying both VLAN strip and QinQ strip is equivalent to QinQ strip alone.
> +
> +Summary of VLAN and QinQ stripping behavior:
> +
> ++----------------------+----------------------+------------------------------+
> +| Input Traffic        | VLAN-strip on        | QinQ strip on                |
> ++======================+======================+==============================+
> +| Single VLAN packets  | Tag in vlan_tci      | Tag in vlan_tci              |
> ++----------------------+----------------------+------------------------------+
> +| Double VLAN packets  | Outer tag in vlan_tci| Outer tag in vlan_tci_outer  |
> +|                      |                      | Inner tag in vlan_tci        |
> ++----------------------+----------------------+------------------------------+
>  
>  * **[uses]     rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_QINQ_STRIP``.
>  * **[uses]     rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_QINQ_INSERT``.
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..ccf0cf5e30 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -1552,11 +1552,31 @@ struct rte_eth_conf {
>  /**
>   * Rx offload capabilities of a device.
>   */
> +/**
> + * VLAN strip offload.
> + *
> + * When enabled, strips one VLAN tag if available.
> + * If multiple VLAN tags are present, it strips the outer tag.
> + * The stripped VLAN TCI is saved in mbuf->vlan_tci and RTE_MBUF_F_RX_VLAN_STRIPPED flag is set.
> + */
>  #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
>  #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
>  #define RTE_ETH_RX_OFFLOAD_UDP_CKSUM        RTE_BIT64(2)
>  #define RTE_ETH_RX_OFFLOAD_TCP_CKSUM        RTE_BIT64(3)
>  #define RTE_ETH_RX_OFFLOAD_TCP_LRO          RTE_BIT64(4)
> +/**
> + * QinQ strip offload.
> + *
> + * When enabled, strips two VLAN tags if present.
> + * If only one tag is present, it behaves as VLAN strip.
> + * The stripped VLAN TCIs are saved in mbuf fields and appropriate RTE_MBUF_F_RX_* flags are set.
> + *
> + * For single VLAN packets: Tag is saved in mbuf->vlan_tci (same as VLAN strip)
> + * For double VLAN packets: Outer tag is saved in mbuf->vlan_tci_outer,
> + *                          Inner tag is saved in mbuf->vlan_tci
> + *
> + * Note: Specifying both VLAN strip and QinQ strip is equivalent to QinQ strip alone.
> + */
>  #define RTE_ETH_RX_OFFLOAD_QINQ_STRIP       RTE_BIT64(5)
>  #define RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM RTE_BIT64(6)
>  #define RTE_ETH_RX_OFFLOAD_MACSEC_STRIP     RTE_BIT64(7)
> diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> index a0df265b5d..23aed8ec69 100644
> --- a/lib/mbuf/rte_mbuf_core.h
> +++ b/lib/mbuf/rte_mbuf_core.h
> @@ -63,10 +63,17 @@ extern "C" {
>  #define RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD (1ULL << 5)
>  
>  /**
> - * A vlan has been stripped by the hardware and its tci is saved in
> - * mbuf->vlan_tci. This can only happen if vlan stripping is enabled
> - * in the RX configuration of the PMD.
> - * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also be set.
> + * A vlan has been stripped by the hardware and its tci is saved in mbuf->vlan_tci.
> + * This can only happen if vlan or QinQ stripping is enabled in the RX configuration of the PMD.
> + *
> + * NOTE:
> + * - If VLAN stripping is enabled, but not QinQ, the tag stripped will be the outer
> + *   VLAN tag of a QinQ packet.
> + * - If QinQ stripping is enabled, then the outer VLAN tag is stripped and saved in
> + *   mbuf->vlan_tci_outer (indicated by the presence of flag @ref RTE_MBUF_F_RX_QINQ_STRIPPED),
> + *   while the inner VLAN tag is stripped and saved in mbuf->vlan_tci.
> + *
> + * When @ref RTE_MBUF_F_RX_VLAN_STRIPPED is set, @ref RTE_MBUF_F_RX_VLAN must also be set.
>   */
>  #define RTE_MBUF_F_RX_VLAN_STRIPPED (1ULL << 6)
>  
> @@ -113,19 +120,16 @@ extern "C" {
>  #define RTE_MBUF_F_RX_FDIR_FLX      (1ULL << 14)
>  
>  /**
> - * The outer VLAN has been stripped by the hardware and its TCI is
> - * saved in mbuf->vlan_tci_outer.
> - * This can only happen if VLAN stripping is enabled in the Rx
> - * configuration of the PMD.
> - * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags RTE_MBUF_F_RX_VLAN
> - * and RTE_MBUF_F_RX_QINQ must also be set.
> + * Two VLANs have been stripped from the packet by hardware and are
> + * reported in the vlan_tci and vlan_tci_outer fields.
> + *
> + * When this flag is set:
> + * - The outer VLAN has been stripped by the hardware and it is saved in mbuf->vlan_tci_outer.
> + * - The inner VLAN has also been stripped by the hardware and it is saved in mbuf->vlan_tci.
>   *
> - * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are
> - *   set, the 2 VLANs have been stripped by the hardware and their TCIs are
> - *   saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
> - * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
> - *   is unset, only the outer VLAN is removed from packet data, but both tci
> - *   are saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
> + * When @ref RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags @ref RTE_MBUF_F_RX_VLAN,
> + * @ref RTE_MBUF_F_RX_VLAN_STRIPPED,
> + * and @ref RTE_MBUF_F_RX_QINQ must also be set.
>   */
>  #define RTE_MBUF_F_RX_QINQ_STRIPPED (1ULL << 15)
>  

Since QINQ strip without VLAN strip would be undefined, it should be blocked
at ethdev layer. Something like:

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..0d51c7cf82 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4542,6 +4542,18 @@ rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
 	if (mask == 0)
 		return ret;
 
+	/*
+	 * QinQ offloading dtoes no make sense without also stripping
+	 * outer tag.
+	 */
+	if ((dev_offloads & RTE_ETH_QINQ_STRIP_OFFLOAD) &&
+	    !(dev_offloads & RTE_ETH_VLAN_STRIP_OFFLOAD)) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			    "Ethdev port_id=%u requested QinQ strip without VLAN strip",
+			    port_id);
+		return -EINVAL;
+	}
+
 	ret = rte_eth_dev_info_get(port_id, &dev_info);
 	if (ret != 0)
 		return ret;
