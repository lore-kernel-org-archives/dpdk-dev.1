Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E3EEE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20C0940267;
	Tue, 30 Dec 2025 19:21:12 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 1205C4025A
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:21:10 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so102076875e9.1
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767118870;
 x=1767723670; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLTcjUsBkjk5BPrd4EGxjyW2FEgozdy9xC8rdGJQphU=;
 b=NAtstYikSVwBXQJCsjkV6bD/2+3nJGDGyP3rirbu7G23bGILa81so83DLIxqepAYBF
 nLZOh9lsQ6nmDbO70haftqg1zIJWpWP300ByvVvgANa7ba90CgvNW0Domka+ZfZ2jbnd
 N4aS5xpNCGz42ufeU8xvtgf5WldTqtRxzQ1k27bq0nTxgfBkPgPzV6CF4UIcgbSNLZY7
 MY5tc2u7s/BN0VtSSDh0NupjAJ9mHcSHnu3fXguAHSa2BvstAR0BFf6Zj6wfSNYdgzpe
 f4VZ6q0PzQPWV0j0n60A9lvJG/fE2UTURUv4wpeSu/n5PcR85jsjTcYGKaCu8Xf386hH
 /PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767118870; x=1767723670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LLTcjUsBkjk5BPrd4EGxjyW2FEgozdy9xC8rdGJQphU=;
 b=NbdxMgUZ63egyq8sULUmnfwLWVNRU7wmRdmLVU687hsVAz8WEu4VFt7ReGrtYFTOoQ
 apKX+CbjGkaQR1imj5qa8SS6FmFOCXfJeN6ZNi+AhYQU9DfC4x8HE4STr6WN8Ieo81mR
 OeCkS/wy0s20PlZFhKmpgYUsXack7GDGQXdBRU8wfRAsNzxvBFEwegbS4n0S5XHNnAwR
 Ug8AUtC6hIQU4RQRgoNoPUoufFiO5WHhlZSH7JJJ0/CxckAwvZCdBtyXV/UT6/E7cM3s
 APWVaKlmx2xMH5Ywd7k/+1mUbcxduKE3UjWRI6W0wGFODCQdG6Scq03Ja1Ubub4AY/+M
 aTBg==
X-Gm-Message-State: AOJu0Yz2X2waFgCHrA7SePVAt8ghrcDSPl7rYXmx1mR4akJYISDgnYC2
 UK9NwGjE9ovSt9lnKfFOUU51xbY43hb8eCDE4wOBlYsQlsHmOJcSNQxMKu3B4hytYro=
X-Gm-Gg: AY/fxX6rb4tJetneMCc2KrugJtsRqGZjPOTR6sGL6U0p5gr6zsTg2EOqGIeSXsb7WSy
 zjbBk4gcOS4Eo1sTeSoy5QICsL0uRk2v1rscm2vDIc7QIHDpLE1Nh/BD4dkbXrdO7R+l+l00I2a
 1JQCnceuaeFLo2GOjMI88k0MHAlGEa7qOBoJ+bbAsnuETFhZHOoiO4/5m73FmGHKT0NZU3tUf9v
 6ghJazav0jGZPY2+zesCR/fF3vJwcoUR1ohz/O/jRJvtLJihg/keUSTkxuV5SX/geqsAzH02jEm
 Vq+0cKlhfj0VIvnJmXxITCEu8IWhm+UiaebvQnAuAMHiYkRB+CpNYcDig8UT7qGMbZ18CnzjUEG
 d1oBFQOZlHs+lY/4CpoBuKcs8pzx8ziXjXmScaKXLILh12uazN7lC1XF73Z18Vv9jpValY7xaRh
 A2f8Zl3Qfa4wFgtP7mgIcFYrZ9eKzp69PKcOxw3r1xBfqEYLF0W6S3
X-Google-Smtp-Source: AGHT+IEApASyvcGZrPVDbfarvORXHEHuD2C65Ojxhp2R24ToHrrVOoujduXNB21qD+OLcDhoEwLjcw==
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr521372815e9.32.1767118870473; 
 Tue, 30 Dec 2025 10:21:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm641741585e9.4.2025.12.30.10.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:21:10 -0800 (PST)
Date: Tue, 30 Dec 2025 10:21:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH] net/gve: add reset path
Message-ID: <20251230102105.6f5a031c@phoenix.local>
In-Reply-To: <20251230022958.3842695-1-jtranoleary@google.com>
References: <20251230022958.3842695-1-jtranoleary@google.com>
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

On Tue, 30 Dec 2025 02:29:58 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> Currently, the driver does not include any reset functionality and hence
> cannot be reset by the application. This patch introduces a driver
> callback for the `rte_eth_dev_reset` function which will reset the
> device.
> 
> Also, as a precaution, null out device pointers to rx and tx queue
> arrays when we release the queues during a reset.
> 
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> ---

Queued to next-net
