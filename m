Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D936CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:10:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C70D402DD;
	Mon,  8 Jun 2026 19:10:02 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 30D6A4029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:10:01 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-138129a622dso844178c88.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780938600;
 x=1781543400; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1fSOIYR0FQ0vKZXlUgRZaio2B7GhJhAJJo+rTOF+Jc=;
 b=Lnz5kB40v8x34tafWoN8tKEiJ33MrHeMjkmqUivbIRvgXe+Haufe9VotLqMlbbZnOT
 VsnK299k956Jiaml5KdvarAoxlL3Wp2qz72xpTpQAW4I4ijErq2PEd9MwyhcQHgT3rcu
 iPFsnGYf8gm41pYbFpsPUjFXexIFgz/yXqYYwcayUmUMg9eHmgiVEQGWeN2P78WKTlYR
 MygcYeiuv6wx9K2JI91Vlrh7Xv3DanVQg/eDwCcEW/GUmt/iLmiTqrG3U8/nxj1M250W
 na3YLnv/n/7mBYxJBm34ajowpEWND8E1Ks2k+fM4fYWjtAFD/dfJIjS4ipAZnWdgLyQi
 g/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938600; x=1781543400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/1fSOIYR0FQ0vKZXlUgRZaio2B7GhJhAJJo+rTOF+Jc=;
 b=j2uR8DDC+evsm/cwD8z0PK3oIbcyWhtTFJBFdz064VMdm8f+5unqEHqJ8q6c4UbKKu
 uNSpHqVOXMOwuJXyK8MxWzYWT0aOBzN8cDq3DIGSSfStdRmQC/14hVFFQhEWA9uYi3co
 BYpSLSIqfwBeEk1UWQGRzYvNzqEtsr3cgOOlJRnwffeouR3+DWDSYxzag367/gSlPe5S
 n9pUMMT+wd+JJQTciOzBZsB0ULxsm81QR2mXJVY6OTWdbGEAjsJTMf6Mx1s6lvlkmOrP
 CV/KLvVqopy8SXqh5uejt3y0jTnDZNIrvb7YHmiPBNiDGSjYb2/mrNQBBlglihW8pwjI
 3c+g==
X-Gm-Message-State: AOJu0YwjpYUxWZu2sRZVf4zttQ394GIUPAzQ7W5FF1VjiPgTHst7Ys6Z
 2I9dO3IqHRKSMgV4G++bXDb4gV6up0EHjHlKwwSJZ80WfRXUKA/zDoyf0iY4F07myr8=
X-Gm-Gg: Acq92OG2WYL7fVGewjGQBhi9aSuM7MjLyY+vrs522VWeaLPKvjJYB+2slSHkAIxuBB6
 71TA5MMVAn36c2GIWu5Zer33ePNM68GQstvTMpC9QYmYcErPSbs7wk0JItYg2xJhG/8gQRcLWSG
 QBzjl3p9HEWb+E9DNuo6vmCdpYhRwYo7w/4zeXlpPR250hhWSfw1g6lRJNZrZtV5qxbmKiP6VWE
 +xFyPuGKnFkHrEjvFSD1iRoRsHPPkYozx1N06RxEI/FVAHbxRKYUr86xorrQSxK5FltRPXU3dIc
 igMB+UfZpXS1UzB9CHfF76VI76CqKhRrc0nAImz7ovElPKu1xdIjaAIdMpuIuUN07ixtT8pgavW
 JLGG32mpXG7LBiAq6QKaEk+Wsil15vVtdbUR+9MFcd6GVWYeLuzt5y9eD8TW7O9B9vUPPBaiyOF
 sYTjW+uoPjdjeXrn9RVGAFKr15Aryc06yxAqEQSOiWdKHgnq8fAU21s+POs0yJypFKNPrGO8HS6
 C2osBmijFVgjg==
X-Received: by 2002:a05:7022:2390:b0:136:9ebf:3c04 with SMTP id
 a92af1059eb24-1380670f007mr7153872c88.25.1780938600189; 
 Mon, 08 Jun 2026 10:10:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm21089587eec.3.2026.06.08.10.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:09:59 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:09:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com, Marek Kasiewicz
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH 6/7] pcapng: add user-supplied timestamp support
Message-ID: <20260608100957.251cb705@phoenix.local>
In-Reply-To: <20260608164059.65420-7-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260608164059.65420-7-dawid.wesierski@intel.com>
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

On Mon,  8 Jun 2026 12:40:58 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> @@ -737,16 +736,6 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
>  			return -1;
>  		}
>  
> -		/*
> -		 * When data is captured by pcapng_copy the current TSC is stored.
> -		 * Adjust the value recorded in file to PCAP epoch units.
> -		 */
> -		cycles = (uint64_t)epb->timestamp_hi << 32;
> -		cycles += epb->timestamp_lo;
> -		timestamp = tsc_to_ns_epoch(&self->clock, cycles);
> -		epb->timestamp_hi = timestamp >> 32;
> -		epb->timestamp_lo = (uint32_t)timestamp;
> -

You can't generate valid pcapng timestamps without this.
