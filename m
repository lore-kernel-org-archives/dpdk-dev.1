Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 18:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0596E4013F;
	Thu, 17 Jul 2025 20:12:28 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id D1DBC400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 20:12:26 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-7048c49f1f1so11735946d6.0
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752775946;
 x=1753380746; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJ9vwoXyyMZ8Lpr/2FqhjigTmp5uMYz+26phuGuJDZ4=;
 b=gk7CvhijX/K3SDkp9mF6ZMse+WGJ07nyu2rSmKhaZa3GnZtcSTPPSCdnG+ZIEm6DhC
 R4Jiq7aFmdVm1EM0L30bfbNvki5DabOTQK9e1OIiXFaTBg5yDbkkyFI5BNnQIwr1EZ/q
 riQteQ/oXsvXfDWRt7MuT9s4lJ80hSVbTUA9qDu51rzcaSvQ58E0EH2RDrmk2QOpmu2X
 qSrJpraST3jG2SETT2PioitgkJJi0K11X/wfWpMMeZ2tuvT0qdY4BeCLp6tbkceZC3Bu
 sCv8n+L0Pk4Gx23EIUGY4XwY/iVl21N/oIOgk7kieit/qT3a7CzAHFp38KqlOaR4AoVm
 AN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752775946; x=1753380746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJ9vwoXyyMZ8Lpr/2FqhjigTmp5uMYz+26phuGuJDZ4=;
 b=vaNXM5LSw3r9lSxAe0vwvSpOVKf4OwOKAaqApjtfE9hVv1JLJDK0Rm4FiMVXoP/B+o
 f3P34TFH3BHLSprBHUA5Mdb+J78GxemslVq4rKKFh5X7pWsZYURFwbpCqeWGDEWBCcN+
 73BElyc94zPQBGsh6oD9FwuioKDx2QDPzwGa0bbPzI5EU5+UZB/YSvo8X9XhEf73GKRQ
 0r5E3EcAH1piZWqWaBGY8ZJXQKkZgw8m06hlGJTr+CAF7Io0Bex5ZqOQdA9evCpHTvlc
 NzZQxKFcOSiyzfhL9Fn+p77pHqYxGVasXkcNBDNaHCbUP91lmuWTbHB3H1h/aWmHKfar
 iZlQ==
X-Gm-Message-State: AOJu0YyZtHUbWLHHorSOlTo3Cw/uprZHbKvfw7vNEvMfAcHBcwLyyY5f
 E/ENSnOrzJiZIvNLlSWSeh+RdMrYrzzoqLl9UfXKeTqZ9i9ubW7hrXVd+4uM1ZMov6z1Iqz3Mlg
 HDje4
X-Gm-Gg: ASbGncur+abEsknLyoDnB7icNbzo2PPIkos9oDoXZ4uaLgD6yzMLcObBhTRxKs2KPIx
 3yn8oKauVOs0Pot0g/3h1FlUjCiGVvAVkco0eprbErlOCleZcQDqrqPDoCcX6TRiWN/C1AqSnWG
 2CPdRqNTeqY5Z9mdIoMJmYHSz4m2w6sPqbjPDqTBQxjiP1t66b201wEdYA6y7YgRpxRYEw5AIMX
 /M207W6PzLWDZyWtq/pxGOHmHHNqnl6gq8Q5AFWB5MI8T/fyaHxxZOZ/k4Ld8/AFQiJcZz90fnC
 DPnnZpf4sNW5mSQp2bCgwZWNdAGQ3YsKdo61zpascAOxYlx1m/9Jr6hoN5csXJYsBJCctxa/4Dx
 DuHyIGoDgo9oySei8C3Udx3W8qwcaQ/rICKLGzuZcwaiASG7Xfv8moOO5eh4VO2k1GMSOZLb7Al
 gLfHLkhQNiUg==
X-Google-Smtp-Source: AGHT+IEfgS67lyOqy7rhHy1g/uYHTB1ipQyK+JG2REBlgu2aLOTlzMPJOlVkRQbDSJHsALpoWtGEAA==
X-Received: by 2002:a05:6214:4689:b0:704:8db8:d3cd with SMTP id
 6a1803df08f44-704f47f0cbfmr116775246d6.8.1752775946020; 
 Thu, 17 Jul 2025 11:12:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7049799f376sm88083416d6.4.2025.07.17.11.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:12:25 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:12:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250717111223.5ce668ad@hermes.local>
In-Reply-To: <20250710012021.7698-3-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250710012021.7698-1-liujie5@linkdatatechnology.com>
 <20250710012021.7698-3-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 21:20:10 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +next_desc:
> +		cur_desc = &desc_ring[cur_idx];
> +		staterr = rte_le_to_cpu_32(cur_desc->wb.upper.status_error);
> +
> +		if (!(staterr & SXE_RXDADV_STAT_DD))
> +			break;
> +
> +		rte_atomic_thread_fence(rte_memory_order_acquire);
> +

Maybe the heavy weight thread_fence here could be replaced by using
atomic access on status_error which is really the only part the driver
is looking at?
