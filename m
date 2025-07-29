Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD1C87FCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 04:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5126840668;
	Tue, 29 Jul 2025 06:19:25 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 3C75B40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 06:19:24 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-702cbfe860cso42829066d6.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 21:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753762763;
 x=1754367563; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjC7rvpEbrpFNbw4RfbncWaPsBpf8wsqEtEDAkU3FuU=;
 b=Q/rDKGuvKDTlflJTTKO4DpTDOPPuaDM1T6jQrWlqLdFyucgiVYlyscf4DfWHLS1Ox+
 oMDAqLXaj+1VWe6z7Tocum8sxj6fm2lR/rH5gbOv5Wha+9VQD2gRzBgbHoZF1u9mncZn
 nc1DnGklqAz1gPQJUtyHbKijcxyEywHx7AH4iPWzOFP8AwJYJQRMuo7SUJUPdXG2xErL
 1Mg3pVV1/peszyna7HPt0QGnyXeGSCMhICxmMbBKcB1EwjzF4zzVzePeRqsjK6zvqMBy
 H/JgviACYbqt7G6JfF9a5yxSpxXW2c+V/FC1a5b2DNV6j0B5ToU203JePOMq7XQ5RRmu
 DElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753762763; x=1754367563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjC7rvpEbrpFNbw4RfbncWaPsBpf8wsqEtEDAkU3FuU=;
 b=eNPijtInf56LWNCSLFbpl7fY+g2qJTBYNu7kHWrlco2FBf6rPzqRJqqE6O6gmy3kpV
 VcMAmIzE4E5tONCZfoo1hSRaaJsZKKIf/sMbyaG9BY27KVfRntP3uzqAaEbl8ErUrFb3
 FL55a9S3qUnMVpQh7q+Wd1GqjAKryvGyoTVspxuGukjYR4qWjA8Vml8jZ8r/Mx4Mdtwg
 wOpB9sO4Ic2LuPSg8BAszEisXRxHKUgy3FIgW5sGOiaIiPHvzQONNUWp2k2PsaHdv3Q3
 8yRhga6UdOZhDdK0WoaF59abt4yfcCp2ei6kO0b9iy50bSmwRvx/c+SMDJui11UyitU1
 4fog==
X-Gm-Message-State: AOJu0YxQb1pO3pFq4GwY24QdgXb6hzqEa4XEnB3GAaRt2jB+HV6/teIN
 DBe9Xwf+BBkng83GmptG6lhMNEQde7pkHomEUGayLBM9bW0QLdz3su+FiAUwiUKy4SE=
X-Gm-Gg: ASbGncsTr3YgkT1vGCARrYJIrGEIUAemGxsA5wYDxZmOAENZliUQMbUM2IFrMJp/6t8
 fPS1klsyxqtUvJcVzexVLe5zO+gTT6+CmBxDATGLIKR6zmJHoeh3UKc1WQSOVkzjn1mIRjpEGUe
 WlKyzgZXf/07RIp+MlIgRD72jvu7hLhXGsCL2pF9x1eiYx4GMkpHjXXKzbhAMiZDevKlgkR74SW
 FBEv/MmhMOxPLzKI19+FJU1HuDdKmWZSvM/gb0w6TfoORiK4CcZ8+j1uMPwmRaPUM7fRiL694sO
 5GKPmYCAdguS1QxiP6OizwU6Ja73JTawhWOWZ7k3yAkx+Cpniu13Iqi+F5t3JXrfQIQB3GOcAzb
 EqNuXRH3cYq0UXQXQsiFcyJ+A81ustHNOx19QoxEGeKZM7THbt8gvtpeWrL4jpDKWeeHUQ+meci
 aaiHC/5JszTQ==
X-Google-Smtp-Source: AGHT+IEQUOzpLZIHF8SNGilm0yuPCQfotJrbwYXroDkei8psnvyWthTyX+KQQNn9yULNcH1orKrWRw==
X-Received: by 2002:a05:6214:4508:b0:707:284b:53fe with SMTP id
 6a1803df08f44-707284b58e5mr204109656d6.13.1753762763462; 
 Mon, 28 Jul 2025 21:19:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70729a63240sm38776276d6.27.2025.07.28.21.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 21:19:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:19:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] app/testpmd: add flag to enable RSS for single-queue
Message-ID: <20250728211919.75320c85@hermes.local>
In-Reply-To: <20250715125330.2127309-1-bruce.richardson@intel.com>
References: <20250715125330.2127309-1-bruce.richardson@intel.com>
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

On Tue, 15 Jul 2025 12:53:30 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> For testing purposes it can be desirable to enable RSS even when only a
> single queue per port is in use. Add an "enable-rss" flag to testpmd to
> match the existing "disable-rss" flag.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Applied to next-net.
Does it need release note? or other documentation changes?
