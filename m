Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F37C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEB8040A7D;
	Tue, 20 May 2025 17:47:28 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id D9F1E4029C
 for <dev@dpdk.org>; Tue, 20 May 2025 17:47:26 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4767e969b94so105599421cf.2
 for <dev@dpdk.org>; Tue, 20 May 2025 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747756046;
 x=1748360846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX82ATZJUqZwgYPwyH22EFqD+kGxnGwkWT0MmysP6vk=;
 b=Y+Zgzjy/iLx/JQlWkkAQQ8Fizw4qvGpP8cb4tCHzf8J15qEEN/KMbLgJDqCqQYT8zp
 fqvoFxn4rmCqZ4Z/RXH825tcyAQpxHtZR4SIM8xR7CQWwQxcYOWF7AXOYmpkZfCzEKQt
 X+BW8nKyglPmGFltR7L5/9k3Ky6wCvbTYyHUYiTLgIvDzNjT98jN2YTqlpyXyOc+TeBk
 Ahrm5SVoki2O7UpkCyHKClcBzo5xN98WufFx3UwIDPgdJD/j3EQ/yhBtxy55ILcPt5fq
 yVJJlAEtVduE4d0xPZMESOXzzMjrBMvWobnhLGbtv3iwz55fG/LIhxnha7bmF4aBs9W5
 RYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747756046; x=1748360846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX82ATZJUqZwgYPwyH22EFqD+kGxnGwkWT0MmysP6vk=;
 b=YtPAjooBSgfc7dyQUYtQ/JATAsYkmiaJc1d28/GcLs2IqpWBr3pKT6KaYsvYjQwVdf
 aJIxB3XYVYBcmYVc4Aqo1QOGGujWLuC+hwUHJkWq+3zveMJN4dfFeuFoCWUc6huqFaME
 AXiv1U1Ay/FBlKzP3WOY25S5zNtkkeeC9M7HWhMp/cDfjfJT22+uayoRflSDw1Fdqa6A
 hYNOsmfwOAEhDjMH2prb2gU3zxVrTJrltOZ6v2xuD2dxY9DqLl0W3o2acKbSdZb944mN
 Yy7hein76j5E5sVcDp0aIlktdzBzU8OsfFFD1VqklpEiwAXKtRcX+GV8PMO3cnYvYyWu
 jsyA==
X-Gm-Message-State: AOJu0Yxjq9yHo7Wcog6pci2JkCiV7nUUVPoLIYfgxHGV+sRMmSfbfpoK
 w6g3h/kAQAzTEQDA2Fg1mPSs2fz1QYLNKh1rdkWvrEnUIJFeS0JjKSKok8bJAwM0Pwwx4ujko7n
 qW/xSzL8=
X-Gm-Gg: ASbGncsB8/5sp3qUsRaItNnVgqrS4QcrJCgKI4sV7d/qwro2GbhNQsQn9/6+oEKsCSE
 fop0oUFtBk2siDDTOJTjeSRcRwjn5eIOg+baKfph77pGuNM1BIFNWKKnbEqa91tHS9pllL0+Uk+
 GNFWUabDbu88TFsPEBngahKzqkimwSNpFyy6xlDElAotP3GvDBlgfl/N6AdD4hP00pMI7DNDvM7
 55JVXao918XIYLe0+psinhWGWNgAyqqsRXe6AChlUNByskgUj3uTEBz0u1ZOfV+dJCsam700rMe
 8z8z1SSLE9XO2SVugY4Ac7VMPZC2rBebwOLzuP25o2fj7jY9rzyTAe/yF9h5GKeNVnUPL94d9h8
 /NhXWszVwD4QWcCQBfGifppISb71O
X-Google-Smtp-Source: AGHT+IFijpgHZvll8NA9adrsNdl1900wpaePf+eKK7DRSSgxx1Ic/VbTn8/BxqLmV5vtpqY6YmAPHg==
X-Received: by 2002:a05:622a:ed0:b0:499:36b4:6883 with SMTP id
 d75a77b69052e-49936b46948mr100473761cf.11.1747756046088; 
 Tue, 20 May 2025 08:47:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae5013d8sm73304621cf.49.2025.05.20.08.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:47:25 -0700 (PDT)
Date: Tue, 20 May 2025 08:47:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 00/18] add hinic3 PMD driver
Message-ID: <20250520084721.5c10e103@hermes.local>
In-Reply-To: <20250418070306.9290-1-wff_light@vip.163.com>
References: <20250418070306.9290-1-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 15:02:38 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> *** BLURB HERE ***
> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> Feifei Wang (3):
>   net/hinic3: add intro doc for hinic3
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
> 
> Xin Wang (7):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initailization
>   net/hinic3: add MML and EEPROM access feature
>   net/hinic3: add RSS promiscuous ops
> 
> Yi Chen (8):
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism function code
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add FDIR flow control module
>   drivers/net: add hinic3 PMD build and doc files
> 
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |    9 +
>  doc/guides/nics/hinic3.rst                 |   52 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_07.rst     |   32 +-
>  drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  975 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  719 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1392 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  199 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  392 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  121 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1828 +++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1527 ++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  433 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   39 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  148 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   50 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3866 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  167 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1394 +++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
>  drivers/net/hinic3/hinic3_flow.c           | 1700 +++++++++
>  drivers/net/hinic3/hinic3_flow.h           |   80 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  827 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  169 +
>  drivers/net/hinic3/hinic3_rx.c             | 1096 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  356 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  315 ++
>  drivers/net/hinic3/meson.build             |   44 +
>  drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
>  drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
>  drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
>  drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
>  drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
>  drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
>  drivers/net/hinic3/mml/hinic3_mml_lib.h    |  275 ++
>  drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
>  drivers/net/hinic3/mml/hinic3_mml_queue.c  |  749 ++++
>  drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
>  drivers/net/hinic3/mml/meson.build         |   62 +
>  drivers/net/meson.build                    |    1 +
>  57 files changed, 25926 insertions(+), 31 deletions(-)
>  create mode 100644 doc/guides/nics/features/hinic3.ini
>  create mode 100644 doc/guides/nics/hinic3.rst
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
>  create mode 100644 drivers/net/hinic3/base/meson.build
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.c
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.h
>  create mode 100644 drivers/net/hinic3/hinic3_flow.c
>  create mode 100644 drivers/net/hinic3/hinic3_flow.h
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
>  create mode 100644 drivers/net/hinic3/hinic3_rx.c
>  create mode 100644 drivers/net/hinic3/hinic3_rx.h
>  create mode 100644 drivers/net/hinic3/hinic3_tx.c
>  create mode 100644 drivers/net/hinic3/hinic3_tx.h
>  create mode 100644 drivers/net/hinic3/meson.build
>  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c
>  create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h
>  create mode 100644 drivers/net/hinic3/mml/meson.build
> 

If you can in future, please try to fix spelling in base/ files.
It would reduce the checkpatch warnings.

There are spelling errors in non-base files as well.

### [PATCH] net/hinic3: add dev ops

WARNING:TYPO_SPELLING: 'regsitered' may be misspelled - perhaps 'registered'?
#327: FILE: drivers/net/hinic3/hinic3_ethdev.c:331:
+ * The address of parameter (struct rte_eth_dev *) regsitered before.
                                                    ^^^^^^^^^^

WARNING:TYPO_SPELLING: 'resourece' may be misspelled - perhaps 'resource'?
#1893: FILE: drivers/net/hinic3/hinic3_ethdev.c:1897:
+ * and free io resourece.
                ^^^^^^^^^

CHECK:CAMELCASE: Avoid CamelCase: <PRIu64>
#3522: FILE: drivers/net/hinic3/hinic3_nic_io.c:550:
+				    "err: %d, out_param: %" PRIu64,

CHECK:CAMELCASE: Avoid CamelCase: <PRIx64>
#3787: FILE: drivers/net/hinic3/hinic3_nic_io.c:815:
+	PMD_DRV_LOG(INFO, "Update nic feature to 0x%" PRIx64,

WARNING:TYPO_SPELLING: 'coverting' may be misspelled - perhaps 'converting'?
#3905: FILE: drivers/net/hinic3/hinic3_nic_io.h:100:
+	/* Hardware will do endianness coverting. */
 	                               ^^^^^^^^^

WARNING:TYPO_SPELLING: 'indrect' may be misspelled - perhaps 'indirect'?
#4428: FILE: drivers/net/hinic3/hinic3_rx.c:448:
+			"Set indrect table failed, eth_dev:%s, queue_idx:%d",
 			     ^^^^^^^

WARNING:TYPO_SPELLING: 'Does't' may be misspelled - perhaps 'Doesn't'?
#4471: FILE: drivers/net/hinic3/hinic3_rx.c:491:
+		PMD_DRV_LOG(ERR, "Does't support rss hash type: %" PRIu64,
 		                  ^^^^^^

WARNING:TYPO_SPELLING: 'possition' may be misspelled - perhaps 'position'?
#4519: FILE: drivers/net/hinic3/hinic3_rx.c:539:
+ * Search given queue array to find possition of given id.
                                     ^^^^^^^^^

WARNING:TYPO_SPELLING: 'pakcet' may be misspelled - perhaps 'packet'?
#4704: FILE: drivers/net/hinic3/hinic3_rx.c:724:
+	 * If RSS is disable, no mbuf in rq, pakcet will be dropped.
 	                                     ^^^^^^

WARNING:TYPO_SPELLING: 'indrect' may be misspelled - perhaps 'indirect'?
#4771: FILE: drivers/net/hinic3/hinic3_rx.c:791:
+				    "Refill rq to indrect table failed, "
 				                  ^^^^^^^

total: 0 errors, 8 warnings, 2 checks, 5700 lines checked

### [PATCH] net/hinic3: add Rx/Tx functions

WARNING:TYPO_SPELLING: 'indrect' may be misspelled - perhaps 'indirect'?
#213: FILE: drivers/net/hinic3/hinic3_rx.c:955:
+				    "Refill rq to indrect table failed, "
 				                  ^^^^^^^

WARNING:TYPO_SPELLING: 'warpped' may be misspelled - perhaps 'wrapped'?
#1068: FILE: drivers/net/hinic3/hinic3_tx.c:921:
+		/* Task or bd section maybe warpped for one wqe. */
 		                            ^^^^^^^

total: 0 errors, 2 warnings, 0 checks, 1104 lines checked

### [PATCH] net/hinic3: add MML and EEPROM access feature

WARNING:TYPO_SPELLING: 'reslut' may be misspelled - perhaps 'result'?
#697: FILE: drivers/net/hinic3/mml/hinic3_mml_cmd.c:292:
+copy_reslut_to_buffer(void *buf_out, char *reslut, int len)
                                            ^^^^^^

WARNING:TYPO_SPELLING: 'reslut' may be misspelled - perhaps 'result'?
#701: FILE: drivers/net/hinic3/mml/hinic3_mml_cmd.c:296:
+	ret = snprintf(buf_out, len - 1, "%s", reslut);
 	                                       ^^^^^^



I notice the rte_flow check fails:
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
