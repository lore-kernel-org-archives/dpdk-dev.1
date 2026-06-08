Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198ECD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EFBC402DD;
	Mon,  8 Jun 2026 18:38:12 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id F144B4029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:38:10 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so2528711eec.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780936690;
 x=1781541490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJq0rjelZOiKpb1ynEkC8QlWP/L2ivzNC8rqQGm/PuM=;
 b=UZ+KRPj/ktYW8V4UqVQLI4/vMcRU7xAo1zH75yROmGWlsGXR7K7+VcT9YSV3IhoScX
 kMWnhbWwZi+9/EgOue46W/dv86xtwmPaxWar6r95HaAaCNsjXUb93P4ONh9XUchOtlTE
 dcv5HkDgRiBvVMJmlxzAMS4zvuJQHEpFP5on0PnGmY/TK24SzjJTcnrodlQ4c/rRo1Ii
 d6iYJIcRlpv2nz22a1RlV5eFlQxIiC4Y7AetiP9iAgQzZopzbb2O1S93if0zSYHhugS0
 +cp5xQIrtat85l5L1tnRg1CvPWaDk0DIpJcKp30sMOiiJTJ1DpiaDEzRzywIw5RGgnkd
 o9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936690; x=1781541490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJq0rjelZOiKpb1ynEkC8QlWP/L2ivzNC8rqQGm/PuM=;
 b=D+Tzm6YYd5ahiMZEWMgh5VpE+ufFnyGqPNiuqFoZZI/0dzC/ssovsre5v+jX35+mhn
 32ldn2HIwoWSHboufwEgUon34jlu97QSZyH+6gkiAKhS2mae+ht2deHQG1E7aACGsd90
 kC8JNFqJ4vncXVenRzqr7GP+BQmZ2Wegl/3QBnq5WheKAU5AKyu1gRQHVnISNTHc/Bta
 q52saV2DiiVkdy1Anz1TbQu57pbAAEeZI47V8hTOSA3X/YAsJDyF0J8y9MeOHLtA25hi
 HjAKlm5Z1+x5TZKSymEdkRV+QYvyxRlhlVct9bytnP5shk6tqrC0Y77M5kbdh5LJu8d1
 OWbA==
X-Gm-Message-State: AOJu0YyW24chr9YsagRvDMoHgllUWhxg25KesStqmwb4hBqV36bUgjCZ
 /fz6a0rQ9k1KlXyOvNao8YU7h+M02LMJYK+rSIiBa+8NDy6QxdFRXRFiYqpv1itYftY=
X-Gm-Gg: Acq92OEGjC3OcZmbXED+f9x65Jc8L9b2ZlhgyNCj+wglCI3MdHRzQVe7xrHYfvU3gZi
 Q5bmeNZv0DkV6oZ56BcqUl/pgb8jlZC2tExrPa8ivYXfOOZikIi8pd9aalDve+q37v9R6ZEkZP3
 H5eCh036Lqhtni2/EkBPdQzmJ/yxvS/i19hvhKDZrqq5RhMWrQTJNWxx5YIBW8C5bVuoy2i1vmn
 VmBknFjg76XQ9cnZpouLlDo2JWLA/9WZO5K5NfHl9c1FSFgFhM3n5+gd1m+jJwB1vI43zXjzGZ1
 +lJRc8S6ODRdVB3Br/hkcudiflFC/2h7gwE7J46x7SfFDUly3EygChURXLPuwF9nd299pKT4BFk
 gY+OxebF0mQ2H2kRIEINGA7m8C7XE5v0gsu2ZnFtMToGuYJ7g/DB6o8KDUqEBCWtmvyOLOuV/G3
 ISoDCDb7IbwtNtcOgAKte6Y11i/zVaAxI0EY0t5zQHHcO4v+c2f72KiNv4ARi7+D8TpwV6Lu+tS
 3Q=
X-Received: by 2002:a05:7300:2209:b0:304:c651:bdea with SMTP id
 5a478bee46e88-3077b22a913mr9495294eec.21.1780936689948; 
 Mon, 08 Jun 2026 09:38:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm24674028eec.5.2026.06.08.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 09:38:09 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:38:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, reshma.pattan@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, marek.kasiewicz@intel.com
Subject: Re: [PATCH 6/7] pcapng: add user-supplied timestamp support
Message-ID: <20260608093806.7b5ac251@phoenix.local>
In-Reply-To: <20260429073111.3712950-7-dawid.wesierski@intel.com>
References: <20260429073111.3712950-1-dawid.wesierski@intel.com>
 <20260429073111.3712950-7-dawid.wesierski@intel.com>
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

On Wed, 29 Apr 2026 03:31:10 -0400
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
>  		/*
>  		 * Handle case of highly fragmented and large burst size
>  		 * Note: this assumes that max segments per mbuf < IOV_MAX
> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h

NAK

You need to keep the correct timestamp correction.
PCAPNG specifies times as nanoseconds since 1/1/1970.


Any new API needs a test as well.
