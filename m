Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695E6C369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:15:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D0F240156;
	Sat, 26 Apr 2025 18:15:58 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 108F7400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:15:56 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso4680955b3a.2
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745684155;
 x=1746288955; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmz606jOm9TLNPMw5+xaBLoDUfMWBchNePUsmy9AOe0=;
 b=BHF7O999CMKNdLEco1RRfZMDh3hp3P2LMgI6epDpHQY4wesP5FDntRFpbtnsh0qZsd
 16fnHVsdKIhRQr+2Yl1xgF+qbfMjqc5uhRoE2zd4RLy7mRBdqkxJHAerHHir0q44BP7p
 s+xhClCI3+MyzGwuWviLRVFO0UOo7q4qz+s4A4O80Kxx5qp0gesdwGaRliAiW2wYPFw3
 wioOVepCY7ht55mbkqbMtbffnrAbwV9vKp9mikQKYwn7qsovJ9AOUl9ya7AhJX/0frRJ
 6SnyfA7L9vfehc4z6murSGm+O/oRIBassBZkvmJEfb/Tr9pDRYsKB2f2NEBq4BqhDx0N
 axzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745684155; x=1746288955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmz606jOm9TLNPMw5+xaBLoDUfMWBchNePUsmy9AOe0=;
 b=glf1CuqW52H0RDo2dx6cm39BsUPv3cA/Bys7diUH8hIlwIan2rZb6By2cNWG5nShIl
 zHcb0Z6WmbGvB0Kg7p9Z4EjA1xNVzA7d+FKweaZxnPF8Jix+9FEnsc3cyNEaJ6jxUFn5
 5zJqrMAEB5w6ZU5P/z1ig9PSw0jgFQk921O6bqqAn4NOK5t0dr4byXLB8cOXKOMMxtbc
 LmoiRCjq+/WArS/0TBdSU3ZQ277yHkB8Yjz7t2xiFAYGL+fBnZd/GBl5yk0OBKihnacU
 fbxtB4NJhNMPDUY8zXioJo3wi91Phz6iI984Vz5WasMV50SG7yQarRh4m5twS7Tw8EyQ
 wSXg==
X-Gm-Message-State: AOJu0YyHx/UTPVm/a3KphvZHOZ5dQyqKp56+R30vwIJ8hYOKU8S2Vho9
 aEojh+1tpbhKepSeQ5IQrU54il6DV/lGZpwrrh/qbxzZQdWYfOl+4oxAbK/CN+PQQl51RLpJu3a
 m
X-Gm-Gg: ASbGncvdEZCazD0ReqwvESkuAX6+WVXSm0u7O+YMdyz3CBTZ/E3LeditqQaDazE/SSG
 H7415flagxaRQqED/wXT1CAmuj2xJy8oMj9M3xhrMK2Rnlr6RKhKnVlxnSAwYnXJa7cfsxwchqc
 6f4iB6yhnrvayffu03RKv4uZf667c9Umf01tWhFCVPxOnFtKXmnhSYa57CwWWnXXx9dOByFtSZV
 WSl/9s7kPl+tepInA2U4YEI138hSl9aZ3uEHQoqmxdXR1P0tN5VTdcqUnVSlpwFSH2WO7w9Z3ic
 p63kw8xtI/mvD38zcxMXQPUgCIEqkMkB8c1RBubnOZFNkPZS+e4hXAskNPfGTwIcgibC08aO0/t
 7ukzYLwEGMbJZdRPj
X-Google-Smtp-Source: AGHT+IG/OCP4FespBBmgGn+icxupdwOofIja497iZhxbftg2JVC2sx7AmpqxxdwUT8z/JuMhFs4DbA==
X-Received: by 2002:a05:6a20:6f09:b0:1f5:8a69:f41b with SMTP id
 adf61e73a8af0-2046a6f0da1mr4666695637.37.1745684155102; 
 Sat, 26 Apr 2025 09:15:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25941fd9sm5175430b3a.53.2025.04.26.09.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:15:54 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:15:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20250426091553.22b51835@hermes.local>
In-Reply-To: <20250425023652.37368-2-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
 <20250425023652.37368-2-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:41 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/base/sxe_logs.h b/drivers/net/sxe/base/sxe_logs.h
> new file mode 100644
> index 0000000000..e90b563eac
> --- /dev/null
> +++ b/drivers/net/sxe/base/sxe_logs.h
> @@ -0,0 +1,273 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (C), 2022, Linkdata Technology Co., Ltd.
> + */
> +
> +#ifndef _SXE_LOGS_H_
> +#define _SXE_LOGS_H_
> +
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <pthread.h>
> +
> +#include "sxe_types.h"
> +
> +#define LOG_FILE_NAME_LEN	 256
> +#define LOG_FILE_PATH		 "/var/log/"
> +#define LOG_FILE_PREFIX	   "sxepmd.log"
> +
> +extern s32 sxe_log_init;
> +extern s32 sxe_log_rx;
> +extern s32 sxe_log_tx;
> +extern s32 sxe_log_drv;
> +extern s32 sxe_log_hw;
> +
> +#define RTE_LOGTYPE_sxe_log_init sxe_log_init
> +#define RTE_LOGTYPE_sxe_log_rx sxe_log_rx
> +#define RTE_LOGTYPE_sxe_log_tx sxe_log_tx
> +#define RTE_LOGTYPE_sxe_log_drv sxe_log_drv
> +#define RTE_LOGTYPE_sxe_log_hw sxe_log_hw
> +
> +#define INIT sxe_log_init
> +#define RX   sxe_log_rx
> +#define TX   sxe_log_tx
> +#define HW   sxe_log_hw
> +#define DRV  sxe_log_drv
> +
> +#define UNUSED(x)	((void)(x))
> +
> +#define  TIME(log_time) \
> +	do { \
> +		struct timeval	tv; \
> +		struct tm *td; \
> +		gettimeofday(&tv, NULL); \
> +		td = localtime(&tv.tv_sec); \
> +		strftime(log_time, sizeof(log_time), "%Y-%m-%d-%H:%M:%S", td); \
> +	} while (0)
> +
> +#define filename_printf(x) (strrchr((x), '/') ? strrchr((x), '/') + 1 : (x))
> +
> +#ifdef SXE_DPDK_DEBUG
> +#define PMD_LOG_DEBUG(logtype, ...) \

NAK
Not carrying custom backport code in the upstream tree.

This driver is abusing the idea behind base/ code.
In DPDK base directory is intended for code shared between multiple platforms.
I.e some vendors support DPDK, BSD, VmWare, and even Linux with common code.

The base directory is not intended as a backport hook.
