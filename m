Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E23CAC5BE
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 14:39:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E18AF4060F;
	Mon, 29 Sep 2025 16:39:07 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id D8F2140289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:39:06 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-854585036e8so491942785a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759156746;
 x=1759761546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEkKbJ686xvqxhiYaUcgBsuTcEec8BgKeUws+JzOhm8=;
 b=N/8/b2HVtbEtUtQSCKpjrfvdmTk+Ijkc4y6SWPC7pO3AoshLne/Mg2RuW83y2cSfqn
 IumzPKAjrmdl5F1y76qax7dKTxVhRkp5g0MIwm+Up1+EjPnuETkVkt7r2Ipcg8ZG8wws
 EPj7waySa86my7naKSNXtqZHmLaWcoM5+jWGscPUvBkTKB3lG/U9rsUv2cejbraMfQll
 SSPPyCv8KLOCAOuJOVwEnk5eaa6Qsp1Ht91NAhMhZxX5jw9iyYGlI10tpfbGImrhM6wx
 qBDJ6yPAOKs8q2wz4aGDeK7wre77KKzrL468ix4WJkMuHFbs31WqIfeVq0+oUw4xS5eE
 eERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156746; x=1759761546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEkKbJ686xvqxhiYaUcgBsuTcEec8BgKeUws+JzOhm8=;
 b=R86m3FY9KUSTMFbgQRfEgvBZ0QkOe8lI6zJF/ElFhRDOm/i9WMStOQXkrbOchR8J0j
 9S0/nIg6MDGY2jX/k/odfBW2vCOOZI8TuwAaGn4GNUb5BeFxCYRtfb/SU0Mg5+GUizTb
 oE7Jnoxc5B0U3h2rhb4iyz8j2HMDMcXRPEMoDM3FpL48N/p3RQ/CCsKpc99XduP2KWm/
 cqIPqf4PkaqTHe7OdY/KxEZ1lMfYjvef2YBr4HBrrFGQaK8YDgUSuje4m1IIjyCDdnFU
 k4jx2ZiODqbMWdZDWoQgk76939X+OGi1WRm61wl9UyYq0BQYWRTRaI3BAgD9DqyMlj6Z
 Hr4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvRj75HLcNXnPW6BjvqnU5o6FrG0vH7Q1GzQrXP7+tsCkhyzC8Jx26NCSJYtJMRdvrQ5A=@dpdk.org
X-Gm-Message-State: AOJu0Yy5YTloVnyFW5E59j32rrooYHF70S+Clh+d419OxEf4bELWidjK
 in+JfeJN9gMTZ84Fzq6xs2e88GevupeqWAKAUOAB9nSQ0Qyk4A/2pMx12KS+K7v+pSE=
X-Gm-Gg: ASbGncs4yPLLKKUMgYCvtYM1+J653gMTB417JTMePKJ4jMU2kUL1w4f9FwwEKC3as6n
 VVSmUVVOfvOlUP5KAee0gWjxz1Tm01ts8IGbO7xirSBT7ctnmthOhY0W5Ga5dpnO+rzSvDM7JJ8
 IhqFsBLQlNACRvJ8FSBl9H2okwddHsUF12ZOb20dIeSY9faXzA0stqkxmNaVZiEJlOpcpZJq36x
 KnCtS1s98/LtzQUZ3GiLQhktjdWPKqcTvf+iXmrY2kjYDAgDGBFo91qkj8lg1+QOsW9wp9GPp+Q
 Ewyhwept785Zs5qHgQqynHgG6A/knqCCW3fNEg348V7IcHqQFynN+tY98JXYC+lMv2/rlr9hiyl
 HJKX80CQ/XAXFRyfjmrt034Qn5buNfnWpRF2f6vEYGRKsYtn+EIufi516le+H1XGe4thtdy5Mig
 Pq4A4dIRULVA==
X-Google-Smtp-Source: AGHT+IHmj4pYQJDg/Mb92bVlrBn7WTnHOj2nq5u8DUehHci0SL4hsxgbyjl649cipdsubipPZdwmcA==
X-Received: by 2002:a05:620a:1a1c:b0:85e:91c6:cebb with SMTP id
 af79cd13be357-85e91d61a7bmr1451647485a.27.1759156745928; 
 Mon, 29 Sep 2025 07:39:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c27099635sm871183985a.2.2025.09.29.07.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:39:05 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:39:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Shetty, Praveen" <praveen.shetty@intel.com>,
 <aman.deep.singh@intel.com>, <dev@dpdk.org>, Dhananjay Shukla
 <dhananjay.shukla@intel.com>, atulpatel261194 <Atul.Patel@intel.com>
Subject: Re: [PATCH v3 2/4] net/idpf: add splitq jumbo packet handling
Message-ID: <20250929073901.102782db@hermes.local>
In-Reply-To: <aNp8T1rYYJHLFoQw@bricha3-mobl1.ger.corp.intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-3-praveen.shetty@intel.com>
 <aNp8T1rYYJHLFoQw@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 29 Sep 2025 13:32:15 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > +			first_seg->pkt_len =
> > +					(uint16_t)(first_seg->pkt_len +
> > +							pkt_len);  
> 
> Since we allow 100 characters per line, does this line really need to be
> split into 3? [I realise this is a copy-paste from other drivers, but we
> can clean it up as new code here]

Also why the cast?
