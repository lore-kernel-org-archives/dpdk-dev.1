Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E318CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 17:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBAD340E2D;
	Thu, 13 Nov 2025 18:32:48 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id C024340151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 18:32:47 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-45033024e59so475156b6e.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763055167;
 x=1763659967; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9agHCU+Ng/ZxqD6/TUhQiVHLakZO+qJ73YBTBViCQto=;
 b=b8VzzpHd2kZ8gHBLWl7+swkW1oTDhBbWTjHngXQiG/CpEpDrRDPgxYSSgvE+c5KhzE
 ghP1x//b6USRhnGyJVC/3W2AtyArc9X8fN4nDdoxe8HGNCES7pY0NOrIOm4Ip9aW25/k
 JRz5K44Jxsmpi3jT85jprMln0dCkHzLFD6uLkAEcDQ3eh2HQqKWpGzAApxIQ+bcN9VGr
 /Oi3fXbJq8BC6YatneVugy+YFac76jNaIl0n+QXT+E6NJY57GKuWlQkJyJCst/TC3kGe
 kHqYtuElyxt6l9tZwaREFA8pA3jAg+BKOmB2xb7s6Z1Dqwpv9tMOD0IJQoqISnqI4d3B
 ubDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763055167; x=1763659967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9agHCU+Ng/ZxqD6/TUhQiVHLakZO+qJ73YBTBViCQto=;
 b=jYTm9COpACeXM+/tMwsE5ZhqoW1YM72ynMx2FPZ/8JaAFlR/ofNH2hH3AXGN1wFMxv
 wJISZRuPzMnC97xW9MyUmAFiv5a9OLcysGH9GmBJByUim0ojQPOhlrKnmN20tN+yRAzU
 QhhPBg2UfoOdY9ZYL6B/kmMTUtxSuFSpT4bfgxgY0oFt1cf04nnIOqdnN09R0MFP7dR/
 Hq+JvqoBKOOQetN9QDPudKi9G4kAtyBshm1e4jG9DQJzL857u22/3ArdOV2CcvwHiHTU
 Gh9Z1DVivgOeDKt6nI0HxVENrergcVHreF7JNa4RNej+ohVadr4LA3eEDhs3vgJ93dHy
 mDVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+XX7Kuw3x51lFKXRata9q6Tlm6mMVqEzGvzxQFHseHsmBv8tiQafGYaq7LDY+Tlk9DC4=@dpdk.org
X-Gm-Message-State: AOJu0Yy0koHttHOiJ3pTZ1ShxJxUKDbcAd5sVYX3tbDvSrIrOal50zK0
 x3ehVRAPHywJFEitLQkDzz6rN+K0kPTs74PD80GP8o7hQou5lrThPSJ3efaW9l9DPf0=
X-Gm-Gg: ASbGncvEaFqJy6uWieivWKIyJQ+GDQ79Q/6kLGSePZ0RbB8QYsXVaYG8lwPq8opIC8D
 xr3yAqE05G9ywjahiqLG91+7erdpug6QkJwrJ5GysIdb9O7+/Ww1J92XCs+VNcdzaNLbBIrYTPP
 6SZvPTB+cbGLuAaFeHXj7TdZUjrj9oRpExvZU1gLv/gPsjw8pI3PEGCQSXctBm5riPxZR/x01gt
 9Z19js+uqyuoc51whIy8mIpqO8ZHfXVcY3rvlQ+jgEEffpmtPgesUjoXt294H+QHlSOVgPXRaDK
 br8GOZIx0Awt26jZjn4qE+TMuGHJRkWL0NY5iH4PfToW4Wcrc8EZXyq5cNoqLbtSC98hY/UnJEI
 tDppk4Ay2Ymlu/9LwTxIZaTula0fvgIj22hvshCKxWeXAmWev96OKBWqh7g7gCILnQr6farfXWI
 +0AcyWbk5xIlLBeCWnkM0Zs/kV0zfvfTrG6KFEqHgETS7oPCoA63AvjVY=
X-Google-Smtp-Source: AGHT+IFrBq7DW2m62R4inUNcaCo0B2LLpOfrAzqqyaqPk1qkbFbjkpano+f2uRArKor/6WWbFxe30w==
X-Received: by 2002:a05:6808:15a3:b0:450:3823:b603 with SMTP id
 5614622812f47-4509749b780mr15033b6e.18.1763055166930; 
 Thu, 13 Nov 2025 09:32:46 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e852044005sm1812181fac.7.2025.11.13.09.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:32:46 -0800 (PST)
Date: Thu, 13 Nov 2025 09:32:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohit Kumar Parjapat <mprajapat@marvell.com>
Cc: Reshma Pattan <reshma.pattan@intel.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <hkalra@marvell.com>
Subject: Re: [PATCH] app/proc-info: allow overriding defaults options
Message-ID: <20251113093236.6c797c43@phoenix>
In-Reply-To: <20251112130326.2674728-1-mprajapat@marvell.com>
References: <20251112130326.2674728-1-mprajapat@marvell.com>
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

On Wed, 12 Nov 2025 18:33:13 +0530
Mohit Kumar Parjapat <mprajapat@marvell.com> wrote:

> This patch overcomes the limitation of proc-info application
> by allowing users to override the default -l and -n options.
> 
> Signed-off-by: Mohit Kumar Parjapat <mprajapat@marvell.com>

This program is intended to be a one-shot read of current state.
Not sure why core and memory channels even matters for this.
