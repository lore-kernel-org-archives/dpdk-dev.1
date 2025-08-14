Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3519CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2493A40E11;
	Thu, 14 Aug 2025 18:59:08 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 1228440B9C
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:59:07 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd237so9028225e9.2
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190747;
 x=1755795547; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6UdepoTLxmuT2577Wc+Q33lOr28RQeANJvPGE/xJxI=;
 b=Xnjc9DxkoHX8y3RzUFfVEd+0vAYnRXLsImnzEBWnqqeUeaOYR0W5L1bAoghLV2mxmW
 zAJdtuzhG73jmU0HY8W6CM4o+7TfeUgb1Tm224Cr298s6vvog8ISiwPCpmxCT8iOK4Ce
 ayGNcq3hhdzDZjYjh7nt+CK3hkEImdLmzXScKcC5Sm/n5N8P9mWamotRu67/DZKXRFhd
 T7zcb9fgk8WzEvpqz0DYH7YpTTSNSNfewz8Eg9XB940DwvtGP+O6sMHhiFdLWsp/1NQi
 iUdWEOcWFR2BzTlfuAj/ozqf4R1n7wbydb1vWMEhxnGRYtxyOAGAH8GdVEpGzToM7iJ/
 Y4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190747; x=1755795547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6UdepoTLxmuT2577Wc+Q33lOr28RQeANJvPGE/xJxI=;
 b=ewt9QVryBX4YtDtT1U1/sodgVZp8nLbJMo+xXTgQy3jheS8s0Ks+lRgKa8lyEWDc/l
 TsNvMBkkgVpXo2us6XP6gG5N3vJAemucLtCKN3ud3n2WpUhGwL1vNFP0mLgl2orZOH7S
 A+2DSs8xFvD4a22peqhABDqrN1UzAMtaZ9sT1xpfrz/UWip3eIpQHAM+ewQWPtekIkUg
 ya3ZYz5WmRQYyUNAQYF42nMkBLb1Ift8CF11hD0ELoAmoT1+YU++Gwjb9OKp7lbLDZTQ
 7idJVALt8ZdFGw5UMg0YJt4aKnz3AY7h3jQRsWgoRwtxBqy/pFxZcIvNYk2QsT7uNE8a
 G+tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcIiktu5EhsTQdHuloFR68OC8IpQ/el8dTfUYIKd7tBnuz1G4MrWZDinY+mJet3libPgg=@dpdk.org
X-Gm-Message-State: AOJu0Yyz/lGd2a4EK/jzUSLXSlFbccK3aRoSIZK33IQ+cQWplsOMyUnW
 N22jw9hqP50wNHNBVW19U3bb7kPQA2yZPLiscldw6fIyTn+deVsgigdi40kfBR6kUEc=
X-Gm-Gg: ASbGncv3JVbGQSQSEbaaPLa5M03xFcA1X7w7/COwuNt5y4DNaFWpzzfuT4SE8zVZUbu
 He+BvgACHuMbxjLzXIO7i3Z9+R3134V7m+hsykPH4Sbwga1fGS/tqS5dAmHEATn6sIJnUtLodud
 XmgYvOeLfcuTV7jiQ3qtah/CB6U3l5eXBe87M/RpF/Wy/osyiGxm2M7Hyx0smGlMUkA3RxL0AoZ
 YF0FEcrnw3IpER4IGG/gKxv5IzUWCbluHhlJUcPzJEXEBcR04dE+krO+rkaskh/aB1JpmI1dBjY
 R2JOHCWdtO2TJ1TNzSoHpaCRNEpg/B5BURV4ZvEms0MkfiUD/bBrx9zHKz/WmlmLp+r/TBn9Uf+
 WAVYXyGH9lovfbfj1kLpYGqw6vK7x9VK8S3FGSfmuvhilHYFmNC7OI8PuFLG0u/vu5gQs3YLMoZ
 g=
X-Google-Smtp-Source: AGHT+IEjvwrAmyXMz9TG61+PYD1hOI6noEkHhppMxTh8mCpmebT5Om3Q9DtMA8ZBvq38Vm8nZK2oOQ==
X-Received: by 2002:a05:6000:18aa:b0:3b7:95fa:ac4 with SMTP id
 ffacd0b85a97d-3b9fc34c36bmr3170117f8f.32.1755190746629; 
 Thu, 14 Aug 2025 09:59:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac093sm54015477f8f.9.2025.08.14.09.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:59:06 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:59:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: ivan.malov@arknetworks.am, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v5 2/2] net/zxdh: add support flow director ops
Message-ID: <20250814095901.49018c75@hermes.local>
In-Reply-To: <20250814025248.2194951-3-chen.bingbin@zte.com.cn>
References: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
 <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
 <20250814025248.2194951-3-chen.bingbin@zte.com.cn>
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

On Thu, 14 Aug 2025 10:52:42 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +		} else {
> +			entry = calloc(1, sizeof(struct rte_flow));
> +			entry_flow = calloc(1, sizeof(struct zxdh_flow));
> +			TAILQ_FOREACH(entry, &hw->dh_flow_list, next) {
> +				entry_flow = (struct zxdh_flow *)entry->driver_flow;
> +				offlow_key_dump(&entry_flow->flowentry.fd_flow.key,
> +						&entry_flow->flowentry.fd_flow.key_mask, file);
> +				offlow_result_dump(&entry_flow->flowentry.fd_flow.result, file);
> +			}
> +			rte_free(entry_flow);
> +			rte_free(entry)

Use the right free function!

==== 20 line log output for Ubuntu 24.04 (dpdk_unit_test): ====
../drivers/net/zxdh/zxdh_flow.c:641:36: note: returned from 'calloc'
641 |                         key_mask = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
|                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_flow.c:689:9: error: 'rte_free' called on pointer returned from a mismatched allocation function [-Werror=mismatched-dealloc]
689 |         rte_free(key);
|         ^~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_flow.c:640:31: note: returned from 'calloc'
640 |                         key = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_flow.c:690:9: error: 'rte_free' called on pointer returned from a mismatched allocation function [-Werror=mismatched-dealloc]
690 |         rte_free(fd_entry);
|         ^~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_flow.c:639:36: note: returned from 'calloc'
639 |                         fd_entry = calloc(1, sizeof(ZXDH_DTB_ACL_ENTRY_INFO_T) * ZXDH_MAX_FLOW_NUM);
|                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
