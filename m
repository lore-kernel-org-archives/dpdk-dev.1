Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D927BC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 16:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33C2640616;
	Thu, 26 Jun 2025 18:02:36 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id AF1C140616
 for <dev@dpdk.org>; Thu, 26 Jun 2025 18:02:34 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6fad3400ea3so11740356d6.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750953754;
 x=1751558554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ0xD3QtvJnAlRctvl01NuIqoSWfykMQ05Bd2kGfJZA=;
 b=DgiwZ8yf7KImw6/lfafUHPh6LT2txWPDnq9Kp0jJOBl1VuXkWuGC5owgpCjDuAWxTe
 PJTVyy07WmD63wPc/cAuvGYDm6lZgackd7ABqHVNZf2d3ekZZEKBO+xCc82iq7iqX6JR
 2liNjEbSshBMTkIhWMvoyDjhitIgXQApAUQdoLhNmHqdWinx+e1Jw2sIzs5L8in8XF+k
 w6ssHLfFoYmsvTEOvJywFUnIcIaU7tsJA1+fNX1SNOiLHVnglJK3v31T3H4f17OozmZu
 1iMvNSNJlSSG56AbJ/kgAs7WtBzNig7/dAM3lJKzg3OKWQU+fP21g2tvSGPhhGsh5Lzq
 775A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750953754; x=1751558554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ0xD3QtvJnAlRctvl01NuIqoSWfykMQ05Bd2kGfJZA=;
 b=PTQwuoddvyih2IXHGxbHucjBkU+1vnUBgrXPj4cBlw4DGj59Ujt9SjOkXj58+2aeJv
 AGjvrti2WiQHYeZFKlGGWFFp4ITRrg5sGA4bu0KxbpNfAXWc03xYTKKLgY2dJN3bTSW0
 /TFxLowAi7KTUAVz3/MXXgoJ1hBtdrucj07LE5e5aIABJ2CKE/SarqruFS7Vt7YWwuWt
 D53jYH1fTkReRvFbxAxFzXTwkvgVy/wvrDlS7UR6e8EQFOdCDRdDdEPFPHNNPOcJEhG+
 Vbohl9DehYQyM7L7jz1T7LADS5UwNNWM9ERa1glMVI5KnTzulZMBevdU/BTzrsEbUtE2
 tCKw==
X-Gm-Message-State: AOJu0Yyc0mEsu9IHlvqZ8Vps0k/mTBgfyVquFyxvwERqnN1Fuwk+t7/I
 gOzFg2iZexE+Eaw25wezIM77UyQlwLvwYjusMbEkaUmbfoHsdc7zlZbqgKoEXV6gvHk=
X-Gm-Gg: ASbGncvGWrIzhsS6+ppzIwLsprjKKUXveOOJxfBBxm6nuO5f49bZ8X3Bx/uModwowa1
 AbK6mZ4MGgkls2w/fWO+ozKNVAmAuvbTmqVs/FYFPv0pgAbCczbjQyJZZKyXDV1akXbI9IlDkaH
 iBtrKqBGd1bxJzUgdV+Emps77Rp7ReCJdrEHaToKI9fTirkkj25Xnfwc2tlMl71juQTPmGcJvHN
 o0XgKfraZucA6YO7zcfM8Ltz61Amoqaci/NBdxVAuqVZ8Z6oPSXz2Ud3QuowF8FInJyJGFZkclh
 RqcrDEIO/MiQwUPDca8I2aewXdQVyP5+11u0NRRLhfOTnFcDu1HJh0QYk93itRM8EVca1KgzREs
 cgj7zW0JkqkSA7aryc++XXlwj8fKdxjTzSev5z8U=
X-Google-Smtp-Source: AGHT+IFUBwfMAiMD2+NqyN8/73JWCuSWBLdmJmZfJ+VUsIOMQvlE6r+enVgd3cExNvo8EI8yZ+C7Vg==
X-Received: by 2002:ad4:5ca2:0:b0:6fa:c22e:e56 with SMTP id
 6a1803df08f44-70000add4f1mr1111426d6.8.1750953753464; 
 Thu, 26 Jun 2025 09:02:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730b726sm8916656d6.114.2025.06.26.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:02:33 -0700 (PDT)
Date: Thu, 26 Jun 2025 08:59:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V2 17/18] net/hinic3: add FDIR flow control module
Message-ID: <20250626085901.7452137f@hermes.local>
In-Reply-To: <20250625022827.3091-18-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250625022827.3091-1-wff_light@vip.163.com>
 <20250625022827.3091-18-wff_light@vip.163.com>
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

On Wed, 25 Jun 2025 10:28:13 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Yi Chen <chenyi221@huawei.com>
> 
> Added support for rte_flow, including ethertype, IPv4,
> IPv6, and tunnel VXLAN. In addition, user can add or delete filters.
> 
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>
> Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
> ---

You added flow support but the doc was not updated.

$ ./devtools/check-doc-vs-code.sh 
rte_flow doc out of sync for hinic3
	item ah
	item any
	item arp_eth_ipv4
	item e_tag
	item esp
	item eth
	item fuzzy
	item geneve
	item gre
	item gre_key
	item gtp
	item gtp_psc
	item gtpc
	item gtpu
	item higig2
	item icmp
	item icmp6
	item icmp6_nd_na
	item icmp6_nd_ns
	item icmp6_nd_opt
	item icmp6_nd_opt_sla_eth
	item icmp6_nd_opt_tla_eth
	item igmp
	item invert
	item ipv4
	item ipv6
	item ipv6_ext
	item mark
	item meta
	item mpls
	item nsh
	item nvgre
	item pf
	item phy_port
	item port_id
	item pppoe_proto_id
	item pppoed
	item pppoes
	item raw
	item sctp
	item tag
	item tcp
	item udp
	item vf
	item vlan
	item vxlan
	item vxlan_gpe
	action queue
