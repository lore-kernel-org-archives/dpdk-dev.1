Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 19:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B596440A4B;
	Wed,  5 Nov 2025 20:31:07 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 41BD4402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 20:31:06 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2955805b7acso11210125ad.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 11:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762371065;
 x=1762975865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTuHpUscqLKMUYJMHYqRNA0FGuuUgwARwdtz9BDUzGU=;
 b=KiHoK0N+nubIjyGKy28c270ps8wLf8so4IkuBGATMGRN3bhYvaLW/oGNe9LQ/dqMMV
 G+f7YuVLcljSYBOSeFQxxHhBtjjKZkFkPtyto84gjmpESQY+YS4xR5B1QLhuJk9HBt5s
 XouMB3HbDDaTCY5jO9USTwB/K/AlsYXrHnnngsF2sbR74D0CkYfyCrgp3rNQk9gOwKRx
 WCsbXv4gDuYf7iwoMIO7btPEG/8QS7cBi2tiw40vN3ePPFHuLGh+0lmkGw421GFxR3qP
 R920wOrGpznWBQTWIuYHpK1AjHlucfYhuVzoMZHd/wNtET7kH/xV1uqNT0rNLoPJPFnD
 avlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762371065; x=1762975865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bTuHpUscqLKMUYJMHYqRNA0FGuuUgwARwdtz9BDUzGU=;
 b=PmtEhqwMBCHSCIIMgxaLxz6SqYKVf9Fgb5drxETjn9OLXCUc4FBwbo57D9XG3zArnt
 4fta8DNRu+bM4nequwuu8tWjwm62MWLNIHARVR4XTaANdiD78L+l0F+8E8oEz7xTxGQb
 Mp/DoaDeZ74WeXyqiwquzNmJ34L6HLT7FWfvEb9tKXLE8n5GcOkTSIuzru12YQWLEqYb
 7kh2ieyhYQEv8hH5puYld4GAmpOaK+vP4GCWBubyt9EdXBn8iJfZD2fTu8QqrJc4Pmyg
 gIc/SQ2fdK0A1OCEDD7WBRrrJGuRnWyocPskDM18D6hw13T5yXMbHdA5tzqm58JnRUQ0
 brGA==
X-Gm-Message-State: AOJu0YxiJ86gj1AeYBD6s2ouBzregd2nf0zpkzIZuvxavdnQDiIY0IW0
 PkMtiT8zWn/vylgUXlSBkiHeynLejlLdxh75rQfvCt+fUDr9n+8O8pUFzLYBx2Usn0Q=
X-Gm-Gg: ASbGncvBl53lChoLbOl35k57cMWcMfTToQKXZc5lPiFDcy768rhgC83BLwD6TeQbqqc
 vKH8zHxBbQbgsagVYp0wlY8Ir5EMTJ2jgFUejLND8kkbkKEamhqgh2cYTeAEwEjvsBl/TuxLqv6
 UBlB48KTnnW9k3+HbEhmr8N4WpuUn9nuO5VadZhnz0lCkSgxvzJdGtlhOEF03s7yFK5JvxC/8vq
 nTSliewPQw7NFqHDYLfYDThPBid8Y8X3EThUj/fMvh+T9PmSBk412yQWlm2m+nu8Z/jCgSkW1Pg
 b9inefhuTc6O0/6iGAcRVOIfpf9tdiMMFCjGh7RWbWAseBrDxJz1zRpJ11geMRIWPG5iuv7mgT1
 g37edE6MBZJoyd7tAdgtfIyecJA2AOcuXS9k3VeXUwwsAibZD6vUHOmKPPilWn5yaKusJ8b6Mz9
 CP+PgzCuwCbJLdUovVmB0D3H1rfKqbHnRG9A==
X-Google-Smtp-Source: AGHT+IGGManx/TNyIUDRQVc45mz+vuZYKkp0rrbLh+QERk2w2oMcH60Q6zFxvQ5zZLm5bhdZCmlQrg==
X-Received: by 2002:a17:902:cf0e:b0:295:3141:4d54 with SMTP id
 d9443c01a7336-29651634db9mr6148495ad.18.1762371064752; 
 Wed, 05 Nov 2025 11:31:04 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca1c86sm3062085ad.91.2025.11.05.11.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:31:04 -0800 (PST)
Date: Wed, 5 Nov 2025 11:31:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 1/6] net/iavf: fix compilation with VLAN insertion
 disabled
Message-ID: <20251105113101.7a6e577f@phoenix>
In-Reply-To: <20251105152642.2981673-2-ciara.loftus@intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251105152642.2981673-2-ciara.loftus@intel.com>
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

On Wed,  5 Nov 2025 15:26:37 +0000
Ciara Loftus <ciara.loftus@intel.com> wrote:

>  static __rte_always_inline void
>  iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
> -			uint64_t *txd_hi, uint8_t vlan_flag)
> +			uint64_t *txd_hi,
> +#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
> +			uint8_t vlan_flag)
> +#else
> +			__rte_unused uint8_t vlan_flag)
> +#endif

This is not the best way to do this. Adding #ifdef there can confuse
static parsers etc. You can use RTE_SET_USED() macro instead.

The ifdef could be rearranged for clarity as well.

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index f513777663..dbe7d2b2da 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -166,15 +166,14 @@ static __rte_always_inline void
 iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 			uint64_t *txd_hi, uint8_t vlan_flag)
 {
+	uint32_t td_cmd = 0;
 #if defined(IAVF_TX_CSUM_OFFLOAD) || defined(IAVF_TX_VLAN_QINQ_OFFLOAD)
 	uint64_t ol_flags = tx_pkt->ol_flags;
 #endif
-	uint32_t td_cmd = 0;
+
 #ifdef IAVF_TX_CSUM_OFFLOAD
 	uint32_t td_offset = 0;
-#endif
 
-#ifdef IAVF_TX_CSUM_OFFLOAD
 	/* Set MACLEN */
 	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
 		td_offset |= (tx_pkt->outer_l2_len >> 1)
@@ -240,6 +239,8 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
 					IAVF_TXD_QW1_L2TAG1_SHIFT);
 	}
+#else
+	RTE_SET_USED(vlan_flag);
 #endif
 
 	*txd_hi |= ((uint64_t)td_cmd) << IAVF_TXD_QW1_CMD_SHIFT;


