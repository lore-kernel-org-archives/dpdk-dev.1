Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9320C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 20:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CD5A4026C;
	Wed,  4 Jun 2025 22:56:28 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id D0C084025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 22:56:26 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso3776041cf.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749070586;
 x=1749675386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K04fVvgQO/2AATCOv96IO3+9DPsIcrf70M6504czxig=;
 b=W2ZCCtx6ZK0xLW5vkGh3HliisM8+4Brl2VkrPsYgHEEXJjUq1OVeK6ubIgp9G+JlHv
 6tvSC5OUP6fPpqwUg0Ioe1MMFZLI299BJINI3G/MPrK0yOrr7AFY4tvIZ+Ht8Yihw6zE
 NVtt90hUTdidBEavdlKbTCpXJgnV1mXAEmOrAUdlxdOEOOSuqplnxxw677J9Gqb1bdn8
 kQ7Hbk/bFP00en1OUqkhYAOzGSJl7I/X3/4wCDOZRj+bt29IH/GsuMV7+5au3tPawkS2
 JKtVB8HW9gS+JMliwEQDP56uKu3/QiRPU62JmS13MeyHJO43HSc0juA2Lyz/UjvcBstN
 cQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749070586; x=1749675386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K04fVvgQO/2AATCOv96IO3+9DPsIcrf70M6504czxig=;
 b=Ngbzok6kmYuOUegjzqQM8RAPtnnjssyroClHPtBtBOS4hIFzQkrYVLSog5y6ts4Tc9
 NLZiXKRgDsXGi7cKkR9O4eUft+RMl00SegMPyo4FW5tbj2B/1f6c3bHP4d9DF2RDMkOE
 G4c31Grj38insQTQUz6WbhNivcWHXMQgFgf9ks5qYrZyHYrPjSrNZmWn2KobjIw9oBXW
 YiH3o+3WaROq5KZqkFHDWspoKWVfSbFzvaXEesjGhQHMlplhNYzwmU+ywAU5/z5q7trC
 h8M7qTELWYyh0cThd0h4Lpc1p/8JE//IROcqojtLSfVej91wtMCjTRdFSKDcKKadQ7zw
 nb+A==
X-Gm-Message-State: AOJu0YygpQTMlfTqqUroblO2jpDgtifwexDj+mYSMrBhCfTb/frLtjx2
 k9Qkw3Y0M+nRyiVABC+whg9wEfVUp1B/9T7fOsyVzCEUEs4p9v4Vw/jt0jXWt80JsbQ=
X-Gm-Gg: ASbGnctF1mEULmDu61Ct5SGte6jLXPwBq8X2+1gSvYno1VPKJ8JHWrWiO7RallKkCwo
 itMF6XPgZ56FF6AoZd815udWCOnJAfiihJ98qKkNIb0WX/PSb7MPqWBfPJ39lViY0lIahrDqCbz
 k7rllwx/KZdHeZTI2TXXDWesOfXlqoF4SOfiy4Hm74jPf4qrLdzBUpXVfWAqzas41y5YskcK5HB
 ly6RqT1bedxOS1PgESZVHGux7BpfJAY65VCd4+ABfFHTyiOw0NRx1zgQ3ff8vPd08r+/9caowRo
 JKSYSCGHysUfX+xkFVFTwJUy5BFJmxQaa8dyRkU4k1FJBQmYZRmXdi78wcHfgQASB/X4uIZ7cPJ
 MfeeTW0xJMvlHKUN0SOpQMhV0Z0tzASPMEgkmZtA=
X-Google-Smtp-Source: AGHT+IEnsMqoD0WG4cw7V7urzeF+TLpzdbf8mXJOVWAdzdqs9Q/JwERGQinq6K5wRX83uJS0bKQtmw==
X-Received: by 2002:a05:622a:5c1a:b0:476:b7cf:4d42 with SMTP id
 d75a77b69052e-4a5a587c55dmr73510231cf.27.1749070586120; 
 Wed, 04 Jun 2025 13:56:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a597687d84sm42891731cf.9.2025.06.04.13.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 13:56:26 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:56:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 2/2] app/testpmd: sort commands by help string
Message-ID: <20250604135622.3082a69c@hermes.local>
In-Reply-To: <3fcf495162a926f844322dcff7485eaebc23ab14.1747996555.git.anatoly.burakov@intel.com>
References: <84ed4f7e118e8003cc00826f605555212ec07781.1747996555.git.anatoly.burakov@intel.com>
 <3fcf495162a926f844322dcff7485eaebc23ab14.1747996555.git.anatoly.burakov@intel.com>
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

On Fri, 23 May 2025 11:36:05 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> When using '?' to find commands, it occasionally is difficult to find the
> needed commands because all commands are not in alphabetical order, but
> rather can be ordered rather arbitrarily.
> 
> To address this, use help string to order commands. This sacrifices some
> amount of grouping (i.e. when tm commands go one after another), but may
> improve discoverability (and most similar commands tend to have similar
> help strings and will be located closer together anyway).
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Ok, but needs rebase no longer applies
