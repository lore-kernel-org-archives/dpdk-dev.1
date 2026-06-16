Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0FCD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:07:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A1664027A;
	Wed, 17 Jun 2026 00:07:42 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id B9A6F4026F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 00:07:41 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so5336463eec.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781647661;
 x=1782252461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fjr/xCNva5sN3Xod6BWsjeKwi8Azwn9B8XcYs2aEGhQ=;
 b=opT5dML/GLdl4DJh6aOPFk7qjsBfmxa/+r74Ay6jYZmYuZVuLuBAj29UZ7ozRz6Q8L
 OxyavpLHqcjnIFxDKVvlhV4/AUipN6fo1XFezfukvZ8OJFgrH8isaIelRE+kFQgqvkUb
 3x4OVgJvMeWTFlJauaH/0fQZqn4ltZRTsLQ5UmA5/8mt3BGKxOXoB3S3weddykehplST
 NDr4M7y0cdcyGCmy2TTkz0vfLydoPNIo/xkvUJO/gc8+mznHQPo6n4k2/G7giTFoQpVI
 sOKuwdat+Nnp9KGvP3fRP63RYlEQzrXZ6qCtoSKgSVV8zwZ2IdLbMlt8FtOmfsnIGuSP
 NMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781647661; x=1782252461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fjr/xCNva5sN3Xod6BWsjeKwi8Azwn9B8XcYs2aEGhQ=;
 b=DlgVrx7TnvjcnIWJyepd+PaHDmNrL4jcUr/GjY9gZN4diCPntsfRfEd4zuEBldl7ME
 JDPHJCDOVWdnjcstO5olKlaooh/OM2V3zP2zUf5JTiUp06NB+T6hS/IV6FebWH8HrDIe
 HSRrLUlBLHkjBM9/XLGtnYR6+zGqPnnkolW5bzpwDlXtlEVVmYTzkttPP5O6huhUPqbF
 F+swkKEikC4bB1EmZQZbqI1Oa5HjyeaMloe3pcQ8BrjLg7NxTTlJwcLfw2clNIxc6+b0
 bfdxiPDQ2CzwYcRRV7gm1P3gr5R0Ork1ETz7dMo6vGiYe7d4y0HnUm7eSrtSDKeS50iT
 fzsQ==
X-Gm-Message-State: AOJu0Yyz+k5y7xBxFXucddbq7p/7ibMuh0aesuTPvXWKfXXYWdEppWq2
 BZe3BJjFAB8iV65xfjN/p32qibPuFV5gOxBgu7Ej6+cHdZR8hFjfkENIItxKr8vV9a0O6CEVyST
 6EMyu
X-Gm-Gg: Acq92OEwW2kTBEobDVa0Xo3bDFZw4hIxnfTqhpM1GtekM2zi5u+sXRdF/xxnOAipb/+
 /Cyen7b5xs8ioEAj08aF7z6r14WoFI0yGE2blLBWxpCSBRkp0kWN/PLs2HXdYglWg8pqEWPsD7W
 TXr1CT8QWFHL+gWl/TsvaCZx+hRHClIigm2s1lLb6N5l6ypsLCoB5RwtmIocmHFJpG3c8joiJLc
 lcjqVu3kRBf+UdDOhT4WsdI/RK8kcEbD9u8ypPBNgD1oIZ4WpSolR4YtoHREy5RY9SPXX25nhbb
 o3GavTb6WvRz25N5Ls0e8pKAqsxA7pbgp6BtzYcc5boZw3VwXRr1pj5wcFqpV5mW+TNLRGTLDm8
 Gk9WD4Tk0ZP38l4/aohc4gPFe2D1xVF5OsmPIjPLqmfSzNLYBLVoVs/GSx+vi1Lxd3pGYFQjA8n
 zMe4IY2sgJnJr5suQ1vN+kKfDwNxl8K3i1rUWRaiLZdb1my+hmQTfqXwN676eWCAXu
X-Received: by 2002:a05:7300:1909:b0:307:75a5:3154 with SMTP id
 5a478bee46e88-30bca0eac67mr672109eec.26.1781647660605; 
 Tue, 16 Jun 2026 15:07:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91f878sm20324769eec.17.2026.06.16.15.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 15:07:40 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:07:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] net/dpaa2: RSS fixes and improvements
Message-ID: <20260616150735.48bdef03@phoenix.local>
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
References: <20260616104717.723087-1-maxime@leroys.fr>
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

On Tue, 16 Jun 2026 12:47:09 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> A set of RSS fixes and improvements for the dpaa2 PMD.
> 
> Patches 1 and 2 fix the RSS hash key: the L4 destination port was never
> added (both extracts used the source port), and SCTP now uses the same L4
> port extraction as TCP/UDP. Both are tagged for stable.
> 
> Patches 3 and 4 are small cleanups in the key builder (a dead num_extracts
> increment, and the unset PPPoE guard flag).
> 
> Patch 5 honours RTE_ETH_RSS_LEVEL_INNERMOST so tunnelled traffic hashes on
> the inner IP header. Patch 6 implements reta_query / reta_update as an
> emulation over the HW distribution-size mechanism, since dpaa2 has no
> software-visible indirection table.
> 
> Tested on LX2160A (lx2160acex7).

Applied to next-net
