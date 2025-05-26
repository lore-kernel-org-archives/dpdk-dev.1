Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 14:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED5DB40608;
	Mon, 26 May 2025 16:52:51 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 1096B402ED
 for <dev@dpdk.org>; Mon, 26 May 2025 16:52:50 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6045a3a2c5eso2167437a12.2
 for <dev@dpdk.org>; Mon, 26 May 2025 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748271170;
 x=1748875970; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8R1XKmTGv7OP+eQlHmdBSIJ1L/u1K8tp2aT8z9eTgyA=;
 b=2DL3S8A10xho2hZsnSyJrzMLpOrGIGn0uQlMd8VM0sbVs6HNVNXuk+Uzi+hTEgScTI
 RFkREis7O6QvwfA7eUW1hhnC3eAM+tuz5WL3dUtOhj9uSZb+NaRhZuiymWBijbuwtkbv
 EE332F6dO3wnXFQxqvDRBiwCDbdpEa/5jPlShgG/qxI5tJPXSaqErbr6p9ez1j4PKoCy
 d7wc1TmzFnP8lXGrhE5TxU/OnqZCCpOsrkLHTcyo0itGhI1/fBe0HuvtQMIm8ISJJ3Vo
 2vHG/66LdST5KDjqxddI2V8Tmxet/r4M45OXvdgS+ev3ISDK/uXAiNuSxLkTFxnBj2us
 7+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748271170; x=1748875970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8R1XKmTGv7OP+eQlHmdBSIJ1L/u1K8tp2aT8z9eTgyA=;
 b=lY7uciz/Ve1CIFBkAE/SsGeJZoLoUX4Ao9ggHIMWdnwNOUmZsp6hfC5wCDnal61IZK
 1QgPawiW9oEbh8Hn6PEqQ+8y3xh/ioID2npmrnFTBegAN9TNtGsLDed0npplSFyebhtK
 OFoHuf3QxP5AWHRCjNDDOFgmb29Q0TMT2fFvySslt2OQrDrZc90YfnNBhhj6NrLPmnHw
 Al9ApODbeh5H3tpMSjVrl31mrxMH8SrX6NSzdEPL2PoptwSGFTSgCeebavqQv0wGHKHT
 zuCOM5LcNslMTvsnTwVsJTvbpQkslBNz0AuEhYx3mY16ZK0M2bwJarYC9YNuf65yRdSV
 qM9A==
X-Gm-Message-State: AOJu0YzBz7WW1KfrKv7Cnn4hc6NvMxC/o9tp9BhpxIg3UsGmPDYK6xnH
 K3ze+ce2XmT0OwSbDtIUmxj0uv5pl2OONp6FcwPsPGABZ2EEDSatZ3B87UwDAA9STe0=
X-Gm-Gg: ASbGncuP9ag06vUDolSbthmpSOpTKS2uy3bbLUFYYufiuixDulZ08yXu94ielT3jleX
 9iICyScDM0Ql+Jwn8p49IIyESaGm7vNaCBph8TBveXIBZZ11p0+Mm0OooCNt4kw0u7H2nh2JhUJ
 0BGsu/4KlvsEHPl38mRbL+J6i2eMX/SgQn7weABINMjJ8GkJ3aTmEDNxzpvOqxjfZPePHDwE7KZ
 gFSDSsLj6BJOqQwVCFjd6W2//nSd3BAG2EwR84RV03cC3MTJdW1O8sTIsQ/KMVKDVFrbOfBZaFM
 KxCG8OY4iVTN0VQU/ArfGHurraSCSwGJJgGFYCnGH1H4zdi6FvvMIFPAQsrQIAE4LeZ+y8iJWhu
 2pY9gsIUbACbuMe9T1CZeHTLea03i
X-Google-Smtp-Source: AGHT+IHWaVVToLt87Ol2ePEEIvcYOrn4mdGq0eb3tqBfy4GWAq4lcu0aR2f9UDJWagq8IS4TE3qqeA==
X-Received: by 2002:a17:907:961a:b0:ad5:5e61:b08a with SMTP id
 a640c23a62f3a-ad85b2a4a94mr753554566b.56.1748271169843; 
 Mon, 26 May 2025 07:52:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d498b2fsm1703678266b.147.2025.05.26.07.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:52:49 -0700 (PDT)
Date: Mon, 26 May 2025 07:52:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, Cristian
 Dumitrescu <cristian.dumitrescu@intel.com>
Subject: Re: [PATCH v2 1/2] app/testpmd: harmonize case in help strings
Message-ID: <20250526075243.20d0b358@hermes.local>
In-Reply-To: <84ed4f7e118e8003cc00826f605555212ec07781.1747996555.git.anatoly.burakov@intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
 <84ed4f7e118e8003cc00826f605555212ec07781.1747996555.git.anatoly.burakov@intel.com>
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

On Fri, 23 May 2025 11:36:04 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Most testpmd help strings are lower case. Amend those that aren't.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Why does DPDK not follow the convention used for years by the Unix
man pages and commands? The Unix command description style is to use
upper case for items in command that are variables.

	.help_str = "port PORT_ID enable|disable COUNTER_NAME",

These strings should match what is in the documentation for examples.

$ ls --help
Usage: ls [OPTION]... [FILE]...
...
  -F, --classify[=WHEN]      append indicator (one of */=>@|) to entries WHEN
      --file-type            likewise, except do not append '*'
      --format=WORD          across,horizontal (-x), commas (-m), long (-l),
                             single-column (-1), verbose (-l), vertical (-C)
