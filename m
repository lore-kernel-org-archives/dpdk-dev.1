Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BECD116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 16:39:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3094D4021F;
	Mon,  1 Dec 2025 17:39:27 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 77E584013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 17:39:25 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4779a637712so26852885e9.1
 for <dev@dpdk.org>; Mon, 01 Dec 2025 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764607165;
 x=1765211965; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrfLcnWTlm/nQtpKzpY4pzBBXQ9qM2EQFKg0gIqHX+g=;
 b=CnScQo8Aq9zFerJK+4HMDaXN5KByp0GmVwoLIH9OfNTsG962WFngcm+SAl5ibbp2rF
 wccBAzdbpcGZt7x7g/SsxnDtSOc89YYrbA7WeJNN/Ae0MDaQoe0dzisvGaAAPy9/nLc5
 Ug6iRv9S6yJD4iubHbIWi2pojgrssVtUfySLJKm0c9bmYNIEHgu9AL4wZg73zTnB+cjS
 pBoxvKT974VcR7BHFCLcn/awUXFy7PLqKG3oVymNV11g3btwrd4rAaLJefdD62jJnuu4
 P2MeowkbMULLh28GcxMaH/jqG/30FAtMN3drW1b4xwDBaEr2j+EDVpU1EYBgtlzbk+vk
 EhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764607165; x=1765211965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xrfLcnWTlm/nQtpKzpY4pzBBXQ9qM2EQFKg0gIqHX+g=;
 b=hrhTFwKM98zZ9y6gPjDDjgANNI97e/NVHjCt/lGqhXTzhxnaelybBvfmUWB67WdI5e
 DK+GwVUtqYorUWBOO7TViuJOjjlXxZ8O9tPLBh6ZTkT2nDeaSpH0AxFOMjmEIUVdL1AI
 +izdHRhDLbtme4/Hay6ngcpnPBJvIVVmzyouf/wLCEUVM2ANyi+KNr+ITm5LGZuj0/2q
 s4TEXLHcOM4eVkVO13wU0IqDISOIO4UdonWYIuFmsxxqyeBfRPeZjc5Cmt0VLyySrbVy
 HORzSFf3NXFAKyoDTasfKqbWAFZGPbPhyyT3FoqP3FbsegFCM71vBp3yw5XWfLPUr85K
 nh3w==
X-Gm-Message-State: AOJu0Yx/ChDH0rlSspqJ8LPk+fBt5kqXRSkF6ApLHvU0qpFAXCa3v8Gd
 6g73ldBSG2Aa+mSJ8gPo1dgsAKFzKPKKWlL/sFBBsg+KbwwMT1yDpACg3T61x4pYmO0=
X-Gm-Gg: ASbGnctgSHBNbUU5H8Mtm6yDBVwU1tlnUojanwLqSTn7Mq5WQbWVrI+K5oF8eo2XUdL
 mOoOdxFCYSg6a3fPHFlwN2HT6pzK56ANrFnpzQq8xwgCKOcOJfa5E4oNLZDy+neZmWV6fiCtkX/
 1MJZlxKkpPitQYGAQM9cOiGHps6OyTCMp4PDWjiu3LhLUaQkYgulQ4bXcOn+vALoW7N0nxn2U62
 +jxUklM3BGQocP7sLFFzno0Meia1fUKtSYlgdd1rJSnfllgfWzAG0zat70zSASDnruMPyPyLbDy
 p6IN8OtOR6Ye0lScB9nv83gPpXjh3GebXMPhaX38IvXPdwx/2V+ydlhl87LnJQiqTPIAQiRpmdw
 WcEj5Kb0jk/cc+clwKkrmDT6oU1qlFH8mKEHdtXBP0SECa7ioZlbgS/R3jECdubpyQZWI114ItY
 yYyKlvmjq/FM6bOGyMu6FY4pC+mKHs5ylWtKo3f1in/ORZMRX8qrI+/8JIhqP9WGo=
X-Google-Smtp-Source: AGHT+IEfM7ijtntM/OPoWkDyGrFmFVQf/b54GsBTc7LUAUGp0rRHNmEmXjlou2YIkEx1/o7k4b5EJw==
X-Received: by 2002:a05:600c:1994:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-477c01740e1mr369285545e9.11.1764607164654; 
 Mon, 01 Dec 2025 08:39:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479111438b9sm280553965e9.2.2025.12.01.08.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:39:24 -0800 (PST)
Date: Mon, 1 Dec 2025 08:39:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Donghua Huang <huangdonghua3@h-partners.com>
Cc: <dev@dpdk.org>, <liuyonglong@huawei.com>, <yangxingui@h-partners.com>,
 <lihuisong@h-partners.com>, <fengchengwen@huawei.com>
Subject: Re: [PATCH] Upload some patches of vf multiple tc and some of others
Message-ID: <20251201083918.1210250c@phoenix.local>
In-Reply-To: <20251127035116.3877371-1-huangdonghua3@h-partners.com>
References: <20251127035116.3877371-1-huangdonghua3@h-partners.com>
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

On Thu, 27 Nov 2025 11:51:16 +0800
Donghua Huang <huangdonghua3@h-partners.com> wrote:

>  ...euse-RSS-config-when-configuring-DCB.patch |  93 +++
>  ...stpmd-add-prio-tc-map-in-DCB-command.patch | 296 ++++++++
>  ...add-queue-restriction-in-DCB-command.patch | 264 +++++++
>  ...p-testpmd-add-command-to-disable-DCB.patch | 158 ++++
>  0131-examples-l3fwd-force-link-speed.patch    |  87 +++
>  ...xamples-l3fwd-power-force-link-speed.patch |  80 ++
>  0133-config-arm-add-HiSilicon-HIP12.patch     |  96 +++
>  0134-app-testpmd-fix-DCB-Tx-port.patch        |  51 ++
>  0135-app-testpmd-fix-DCB-Rx-queues.patch      |  35 +
>  ...support-specify-TCs-when-DCB-forward.patch | 254 +++++++
>  ...d-support-multi-cores-process-one-TC.patch | 292 ++++++++
>  dpdk.spec                                     |  54 +-
>  25 files changed, 4241 insertions(+), 1 deletion(-)
>  create mode 100644 0114-app-testpmd-handle-IEEE1588-init-failure.patch
>  create mode 100644 0115-examples-l3fwd-add-option-to-set-Rx-burst-size.patch
>  create mode 100644 0116-examples-eventdev-fix-queue-crash-with-generic-pipel.patch
>  create mode 100644 0117-examples-l3fwd-add-Tx-burst-size-configuration-optio.patch
>  create mode 100644 0118-net-hns3-remove-duplicate-struct-field.patch
>  create mode 100644 0119-net-hns3-refactor-DCB-module.patch
>  create mode 100644 0120-net-hns3-parse-max-TC-number-for-VF.patch
>  create mode 100644 0121-net-hns3-support-multi-TCs-capability-for-VF.patch
>  create mode 100644 0122-net-hns3-fix-queue-TC-configuration-on-VF.patch
>  create mode 100644 0123-net-hns3-support-multi-TCs-configuration-for-VF.patch
>  create mode 100644 0124-app-testpmd-avoid-crash-in-DCB-config.patch
>  create mode 100644 0125-app-testpmd-show-all-DCB-priority-TC-map.patch
>  create mode 100644 0126-app-testpmd-relax-number-of-TCs-in-DCB-command.patch
>  create mode 100644 0127-app-testpmd-reuse-RSS-config-when-configuring-DCB.patch
>  create mode 100644 0128-app-testpmd-add-prio-tc-map-in-DCB-command.patch
>  create mode 100644 0129-app-testpmd-add-queue-restriction-in-DCB-command.patch
>  create mode 100644 0130-app-testpmd-add-command-to-disable-DCB.patch
>  create mode 100644 0131-examples-l3fwd-force-link-speed.patch
>  create mode 100644 0132-examples-l3fwd-power-force-link-speed.patch
>  create mode 100644 0133-config-arm-add-HiSilicon-HIP12.patch
>  create mode 100644 0134-app-testpmd-fix-DCB-Tx-port.patch
>  create mode 100644 0135-app-testpmd-fix-DCB-Rx-queues.patch
>  create mode 100644 0136-app-testpmd-support-specify-TCs-when-DCB-forward.patch
>  create mode 100644 0137-app-testpmd-support-multi-cores-process-one-TC.patch

Please use the regular patch submitting process so that these patches
can be reviewed and tested.

https://doc.dpdk.org/guides/contributing/patches.html

