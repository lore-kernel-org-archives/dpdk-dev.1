Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD3CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D1040151;
	Wed, 29 Apr 2026 16:56:48 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 927BE40151
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:56:46 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so4259845eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777474605;
 x=1778079405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UQk33XjFHJh91k2jyfh3pWZzDEQTMszca2tzci/C/Y=;
 b=Biw8+vaD+96qD5sMewEIx8KPBmchVzA+hxDoE4bSV9i3XqL8OQkKf6tiFsPkZh4Rgt
 sNOYrZYCks2/AIOeDz9Qcwf/hRyzqRG8zd4o/jncqs8dE5y7rESYbm+i19ijcPUziqGJ
 jfXIz9sQWdLYWs+SCd8CK599+t82jBJ/LejyKS0iCe/XCR7dvVIvqhfNcBoC4TWy2N4d
 iKvp4HC0MWHR/0cWw42xbrEm0GbyyuluEd6N0aGfAgkTE87xcRwLNgwADpAD5z2+w6FL
 4CzWHMwb8wPZgoKXTMb9XHhSpnJwWh4F9BRKPViNUdsMEYAsK9AdfmPtx7e9z+SFE7EJ
 Qvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474605; x=1778079405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UQk33XjFHJh91k2jyfh3pWZzDEQTMszca2tzci/C/Y=;
 b=n29NTTYSNdKsv2GebESOYeXOKWVd0MZNqNfxlcO48DFQqth8Er+AU0KmkXgFTHDKa+
 qUESxd1SYtZG1MJt3m+NVJYCiz/F9K/FUvo/iS7AOQ6LVB9QffoWZrFuWgzL/T2kbluY
 jcR6fDrj/73fkiLn5GtlUmRoIzJBF8q/4PGkrl08xYUb4/hOSYWB6biTk7Cq/ciywNVP
 yUjkMBRG8g/1sZ2kpUPfQY1PBSUPXsfyJzjpEmLgAJjwnGOfi+cTDsUMR3amH8hH9/L4
 4x74we4J6WYUNf/nRR3cgOs3PaXVKlXxDRx+0RyHYFC1XAH7mNHQKx2hk5ADqSN+EsJq
 gULw==
X-Gm-Message-State: AOJu0YyXIDYsz//OyCScnnIHVEzCU5p7xPt9fmSN4tim76Ho92cjnkMR
 yqLwyleHlsEb79bEdSeGN0/K5oGC2rB2n8GTl73p/n0oQLpDTO/TVgZvmeHzf7QltXU=
X-Gm-Gg: AeBDieuIg3cLmxvAtYWcuAPer2wEfbpPgW6DIQhqKchlNZunq39hJnzwaPjaMLoOtM0
 4KqhPho2PtN2emdnDUQTa2JTbxouArx2W/7q6K8aibqW9h+yGk4HE55t231/anXgiJT6mdpjJZM
 bYfxh3PtNWsyQ7Y3Ga3q9Gr+pnzr8lydr4AYwRFY9spBRVibfPgek0LA2MbPlmpMoAjSiQPHqu5
 FRhN42kJ91FPTH1iUgqt1LkDjkW35PsReUWByAldiRTRKZYt+yRAtI/XvTaW0dO2F2+9sN0NwLg
 jmFKRzjCci6y+i2KtsJnz3Y33qMKxetEX+ev1iPhR9LAiMqJugTDPdQsbehOirlvWp54IU9Nzog
 HGM2GQkxXGfUp9OeBpIu6phtUV7VbqslGOuxNt/vhbzXSAyKNZNRGGuh06Sa6vUbeIYDuDHm0cl
 ac7umxz9keEIM85Jdsw/hMU3NIsRQvbyXJQhA4nKG5vGdBMA==
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-2ed09fcf030mr3819522eec.7.1777474605131; 
 Wed, 29 Apr 2026 07:56:45 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1be7e4besm2787234eec.0.2026.04.29.07.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:56:44 -0700 (PDT)
Date: Wed, 29 Apr 2026 07:56:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org, stable@dpdk.org, longli@microsoft.com
Subject: Re: [PATCH 2/2] net/netvsc: handle VF recovery events for service
 reset
Message-ID: <20260429075641.14de6610@phoenix.local>
In-Reply-To: <20260429084955.39164-3-weh@microsoft.com>
References: <20260429084955.39164-1-weh@microsoft.com>
 <20260429084955.39164-3-weh@microsoft.com>
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

On Wed, 29 Apr 2026 01:49:55 -0700
Wei Hu <weh@microsoft.com> wrote:

> Register callbacks for RTE_ETH_EVENT_ERR_RECOVERING,
> RTE_ETH_EVENT_RECOVERY_SUCCESS, and RTE_ETH_EVENT_RECOVERY_FAILED
> events on the VF port to handle MANA service resets.
> 
> - On ERR_RECOVERING: switch data path to synthetic but keep the
>   VF device attached in DPDK
> - On RECOVERY_SUCCESS: switch data path back to VF
> - On RECOVERY_FAILED: do full VF removal (same as INTR_RMV)
> - Unregister all recovery callbacks during detach, removal, and
>   close
> 
> This ensures that during a service reset (kernel suspend/resume
> without PCI remove), netvsc keeps the VF attached and seamlessly
> switches back to it after recovery, without requiring a PCI
> hot-add event.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---

This patch is failing build.
Clang with lock annotations is seeing problems
