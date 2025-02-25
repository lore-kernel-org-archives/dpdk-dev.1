Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0220DC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E016440299;
	Tue, 25 Feb 2025 17:08:51 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9E2544025E
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:08:50 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-220d132f16dso90390105ad.0
 for <dev@dpdk.org>; Tue, 25 Feb 2025 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740499729;
 x=1741104529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHDw50+j2zZAoAKvpIq0GUTDTx3n1AXT/PwdksRdlFc=;
 b=Pj+Mq/Q+AVYVbe3ovZ0N276lKGmgPRFeWQYt95ccTXUkmKnLcrVgRYIgHeM45aRADL
 NFAGLW6cAK9hTFIgUHnvcEa045736GtLhBGuMl1S2G7p6IhiI7nnEVPYtWGTIvBjQgyd
 /dK/+y1uVOpXh/uN09Q8enZ53j/Osm+jsZzhnwJzoaeyU9WLnyEu2xh01oP9VQDvb6Or
 62DQRizVG6LhXdlHUlGFG7Vq4ReVO3oJR/fYax+FZO4UDbjCgGqX4mSH4mln3q+Lemhl
 VIDh+AnSh39WZsdY1IxLiGHK0npMb8IBt0t4b+cGEn6GMcqYILDJ7AW3JQskBxI5pL5r
 ft7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499729; x=1741104529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHDw50+j2zZAoAKvpIq0GUTDTx3n1AXT/PwdksRdlFc=;
 b=DycvVrQyAuMOIcAM9uC1MhXmLtuBIsSPdvDfkiG/C03Bo+WoHJqGCtxfBE1QjyD4i2
 b895PvolQae5IkQDvnc5f2JB3wdvMp+ym3B75hX2xyZOEeb1rMzX7/KyUj+rJomrrgMs
 OHjoZGXGafTxfFV0lK2twGKoL6e6n1KJM7TsIdNjoZQB38wnKZ/XCsWp9vdcCOYU2F9q
 ck4ehKEJhGZqxQqxnmMRwzgO+JMVPbgrE24P3moKsNvbskhKdZiMqTphmUuZ+7LKmJCM
 AF8g5EhVlXDTlqpzAD+OajjOP4nuU3QlSd3H7fDhPgpLwCUTsX51u8ZR8WUnXgiWBbf3
 Xx6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5OYkH2lwZRX7zO3mmcKN9cfsXUnBJdceaEmJkVfbNFQX38OHS6klcVOwO7ejELMrx/6A=@dpdk.org
X-Gm-Message-State: AOJu0YxtjNOjLKI84Z6R55JJHPieyFgyW4+V2yba+E/+8Bk7peh2fHVA
 GbQKAkyYZM5jLDoyDVwyWebLeiEa5P+dpp9tfR77Ld19fC+KnAf6mGCx6b7ntVu7RpkdL1kgrMw
 vl4g=
X-Gm-Gg: ASbGncsRssFYgAGTr0M0e/MuUCWnnC5QNFRqqAXqDP+6DYqh+/FMJPQb/N0AG8R1fjL
 cf0Cf8kVvHU5Xh3JGf5+EJwi2Zz60N3PXdmpuzNwmWzDrsbGU0woGRzwYu7QwQlqoqWd8UxT4dR
 mRDxUquH3n8eIN8LwkjyXvmDEbiCAmkMSktpaJ+9eYal2tOw3eYa5oaAM8QrMUmmH9SgIxB+F2k
 /wcLWTZZ3ewPuU49rs9Nbv0eCA79GwiUdod1tJ7vbhenbOI2dN91U/GlYxZeS7PKTh/3ZTPG8RX
 ZCl/qDCq7PSDW9O+JRvcYasB2sfVHXWYRGOGZZolBA434QwLoJLjKgo3Gj6L9wMy0uoaiY01pbN
 HUCo=
X-Google-Smtp-Source: AGHT+IExR6bcQG6oV9jhimYOGPAIysg9NnXJYZG9SDYoZoVRuGgQZTDUbz2Iln+ij17fj8iOWp1/nw==
X-Received: by 2002:a05:6a21:9006:b0:1f0:ee68:ec37 with SMTP id
 adf61e73a8af0-1f0ee68ec7amr12181136637.27.1740499729473; 
 Tue, 25 Feb 2025 08:08:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a7f9a8asm1744077b3a.95.2025.02.25.08.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:08:49 -0800 (PST)
Date: Tue, 25 Feb 2025 08:08:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, yaojun@mucse.com
Subject: Re: [PATCH v15 09/29] net/rnp: add queue stop and start operations
Message-ID: <20250225080846.50657db8@hermes.local>
In-Reply-To: <1740472886-30411-10-git-send-email-caowenbo@mucse.com>
References: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
 <1740472886-30411-10-git-send-email-caowenbo@mucse.com>
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

On Tue, 25 Feb 2025 16:41:06 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
> index 99b96e9b8e..c3547c38b6 100644
> --- a/doc/guides/nics/rnp.rst
> +++ b/doc/guides/nics/rnp.rst
> @@ -71,6 +71,10 @@ Listed below are the rte_eth functions supported:
>  * ``rte_eth_dev_close``
>  * ``rte_eth_dev_stop``
>  * ``rte_eth_dev_infos_get``
> +* ``rte_eth_dev_rx_queue_start``
> +* ``rte_eth_dev_rx_queue_stop``
> +* ``rte_eth_dev_tx_queue_start``
> +* ``rte_eth_dev_tx_queue_stop``
>  * ``rte_eth_promiscuous_disable``
>  * ``rte_eth_promiscuous_enable``
>  * ``rte_eth_allmulticast_enable``

There is no callback in this driver for rx/tx queue start/stop.
Did you test this with test-pmd?

If application calls rte_eth_dev_rx_queue_start()

int
rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id)
{
...
	if (*dev->dev_ops->rx_queue_start == NULL)
		return -ENOTSUP;

The eth_dev_ops in rnp_ethdev.c does not contain rx_queue_start!

/* Features supported by this driver */
static const struct eth_dev_ops rnp_eth_dev_ops = {
	.dev_configure                = rnp_dev_configure,
	.dev_close                    = rnp_dev_close,
	.dev_start                    = rnp_dev_start,
	.dev_stop                     = rnp_dev_stop,
	.dev_infos_get                = rnp_dev_infos_get,

	/* PROMISC */
	.promiscuous_enable           = rnp_promiscuous_enable,
	.promiscuous_disable          = rnp_promiscuous_disable,
	.allmulticast_enable          = rnp_allmulticast_enable,
	.allmulticast_disable         = rnp_allmulticast_disable,
	.mtu_set                      = rnp_mtu_set,
	.rx_queue_setup               = rnp_rx_queue_setup,
	.rx_queue_release             = rnp_dev_rx_queue_release,
	.tx_queue_setup               = rnp_tx_queue_setup,
	.tx_queue_release             = rnp_dev_tx_queue_release,
	.rxq_info_get                 = rnp_rx_queue_info_get,
	.txq_info_get                 = rnp_tx_queue_info_get,
	.rx_burst_mode_get            = rnp_rx_burst_mode_get,
	.tx_burst_mode_get            = rnp_tx_burst_mode_get,
	/* rss impl */
	.reta_update                  = rnp_dev_rss_reta_update,
	.reta_query                   = rnp_dev_rss_reta_query,
	.rss_hash_update              = rnp_dev_rss_hash_update,
	.rss_hash_conf_get            = rnp_dev_rss_hash_conf_get,
	/* stats */
	.stats_get                    = rnp_dev_stats_get,
	.stats_reset                  = rnp_dev_stats_reset,
	.xstats_get                   = rnp_dev_xstats_get,
	.xstats_reset                 = rnp_dev_xstats_reset,
	.xstats_get_names             = rnp_dev_xstats_get_names,
	/* link impl */
	.link_update                  = rnp_dev_link_update,
	.dev_set_link_up              = rnp_dev_set_link_up,
	.dev_set_link_down            = rnp_dev_set_link_down,
	/* mac address filter */
	.mac_addr_set                 = rnp_dev_mac_addr_set,
	.mac_addr_add                 = rnp_dev_mac_addr_add,
	.mac_addr_remove              = rnp_dev_mac_addr_remove,
	.set_mc_addr_list             = rnp_dev_set_mc_addr_list,
	/* vlan offload */
	.vlan_offload_set             = rnp_vlan_offload_set,
	.vlan_strip_queue_set         = rnp_vlan_strip_queue_set,
	.vlan_filter_set              = rnp_vlan_filter_set,
	.dev_supported_ptypes_get     = rnp_dev_supported_ptypes_get,
};
