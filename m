Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EAACCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 14:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D6B440612;
	Fri,  1 May 2026 16:47:04 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 74190402C3
 for <dev@dpdk.org>; Fri,  1 May 2026 16:47:03 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c1a170a50so2570532c88.0
 for <dev@dpdk.org>; Fri, 01 May 2026 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777646822;
 x=1778251622; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thfBtuwsuZHKsqoBnX6KQBvlFypdtauAQ5+1qkNNXUE=;
 b=XhsfgCrjcg8ukjPEuHuUnH0icXZiUoie9mfngM1+bkGioiHYxkdQB1guOzreQ9fc2C
 GGX3VMQOnLAyam1GZnnmrJRn12L8T0tUj2A7byCxRDMUbP9iyhrm5wWSgvf+isdpXlj7
 zVmXCWdP0X3CmIL8vH7szYb5oE1+BTgkzwOOhsykunOBI4Ku2FRNb1ABw4ZFyG+XCmT3
 ceirDGd+VGhkhw7k3+HBHgVjHbdf9Wwag5pVAelvILfDbptxDm5ePr04rSsyZXYBNIo8
 jm780ny0daVr8DVBV0F40L2/TeaU5GPLV/maZTbTnpJaqUFzW19rivA5MKwVY58pP5R6
 Gauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777646822; x=1778251622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thfBtuwsuZHKsqoBnX6KQBvlFypdtauAQ5+1qkNNXUE=;
 b=MGRnm84p6xgtsoA2acWPbO3Uj5UssABgNii60rSpCvcLomq91VkS/g/KZXXejI/75d
 us/OicA/d0n3diOLS1CjC579VBkMGYa4XKB+LQdrvOdHYqP5uXJAm8Z8hOJo4/QdhL0N
 mBaEtu6oO4lNNKzpFrCY6XCvIoQBGea03ckuZ7P59u4HR70gUwMLkMtQ18XvXl0TW04Z
 yRrdRC9z1PHCuIRFKlyoqgeiBfRKSke9axdf+uhtnFPmFLUC4pa0x6oVBjogtrBfS9G5
 2uO1VISJmCjRZZnB4jf89kBRTOHn8f2A7Lj84rZQnFQAJPmH0texN20vGzN4L144rKhs
 dSxA==
X-Gm-Message-State: AOJu0Yyhs3lv/jtTmVZZFQfRZXvnaxxtVjfcoOEHIyAaMoEkVEdgz1Gw
 LUvnm3MdfdlQZ/FXuj8n004CKHwrF49Wyi5LL0OZLo8TmtgsbOBmm60iux+Bhjnr1eOP5jJRViL
 Zjf4S
X-Gm-Gg: AeBDietXnyRV9p/O9uVDhtcD09uEmRjZ/XS05S2bvh1r7Z6XYky5xKBqwmi/ZMJkpjv
 QVPG6gaQXEE2d/HKpO4HbpPiN+rlB9nZpFhyzTs7nuU3UOgTx/M9AWT20OqE7OzmsbbjbN79bup
 WoNgNuNMIZ92cghm12jV+EkD2gv5w4UzMu8WikjUK6W9CKhVEUiGpDf0qG5v8nRN07xk12afkvy
 LAVp4XruEvAQrDwpGgI9InLL8RcYbqFyGGIrlrVKxb73R3nPumPTtjEbY6p6N2qgXIBzuuBtvtf
 rVy1VpwQJ6VyuAEgo7AHovr1He6S7o836PbBHDgN+XTEU2eMQVF/JuVmEi7bBDKa9BjlqlLenwl
 noTIGAtPgTHdrxDDXND7VSPD7AGcaBuYCKsMTTHhVHNrsBooiGX2ZB5V4uhMK2HYtdoIKVfCU13
 89pYyKFKDDBapVULURHpZeS0BhcTQbEaOiR1BOcLXRCbzuJA==
X-Received: by 2002:a05:7022:6996:b0:12d:de3f:f3ea with SMTP id
 a92af1059eb24-12dead36b65mr3310261c88.42.1777646821946; 
 Fri, 01 May 2026 07:47:01 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71cedsm5758287eec.9.2026.05.01.07.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 07:47:01 -0700 (PDT)
Date: Fri, 1 May 2026 07:46:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 3/9] drivers: add sxe2 basic structures
Message-ID: <20260501074659.5e1607e6@phoenix.local>
In-Reply-To: <20260501033401.316025-4-liujie5@linkdatatechnology.com>
References: <20260501015925.263486-10-liujie5@linkdatatechnology.com>
 <20260501033401.316025-1-liujie5@linkdatatechnology.com>
 <20260501033401.316025-4-liujie5@linkdatatechnology.com>
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

On Fri,  1 May 2026 11:33:53 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch adds the base infrastructure for the sxe2 common
> library. It includes the mandatory OS abstraction layer (OSAL),
> common structure definitions, error codes, and the logging
> system implementation.
> 
> Specifically, this commit:
>  - Implements the logging stream management using RTE_LOG_LINE.
>  - Defines device-specific error codes and status registers.
>  - Adds the initial meson build configuration for the common library.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

You ignored the feed back about drivers writing files
and changing logging.
