Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8BC531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:28:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB8B40653;
	Fri, 24 Jul 2026 17:28:54 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2E4A2402DA
 for <dev@dpdk.org>; Fri, 24 Jul 2026 17:28:52 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so386007a12.1
 for <dev@dpdk.org>; Fri, 24 Jul 2026 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784906931;
 x=1785511731; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QlBNUs4CRL0ucnjqfikILMWdze+QBP7gAqfC4m7yphQ=;
 b=lBPf/6helOCgEG+h5n8cl0M0r0R9Uh2crXoF6us+dva6qYmHA1vtQTLQPBeboaQbtD
 CANIdMl8QRpGI6WWayYfTtY/nt7DOcdZO2hTfgO7KsYa7qgQ2BA9/YMAnRX2JNymqEZ0
 7dcKmu7vyc0OybMYIC18VhIgdRk66HlJjxgGB8yKS8WlYtD0qoHiEmLMhv/qq8ub0m5u
 snI4b8Px0PDe6G6WjMGIaeFqSmmUc/Z9uvOsKxlfRwRJYqKN5tt+ZmcxVmIDtDMDDV+Q
 nXrRgADI+2WwBV4L4GXXcGF1tmWNj04RdmrtX7tdYcVzwriHBUzwSH9UudMelGipRY5n
 p+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906931; x=1785511731;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QlBNUs4CRL0ucnjqfikILMWdze+QBP7gAqfC4m7yphQ=;
 b=UReqTR575XdjxceIw5/anSEkgsRksdw0YNO2DVeS7qBR2MVz/z/Lg4Y2jx+C2unYG3
 ol4QNimbwhL/ytQtUgGiojxgcB8uq+k4C+zv1Mzn1T1ZsZVEudfh4DRw77iQ97Bxxugw
 xWyCQfZ7s5rtFRZoH/O0Sb9XiilA/8A6qRLs07u4HWz2QNTkFMcrfiA33uoiZ9Ld4hYg
 4aEXhIuYqfpG0RVQo615rCTGudlSxMzyLFNnzYm3qECYT9yXgkQZ99YBc6IYHvl4W0Dq
 YuWFQtF0Qfs+OwION2hm2F+cnfKBdDPgo4TZs5596fibK2+KtIRp1Uiljed0I8FMjkLZ
 hBnA==
X-Gm-Message-State: AOJu0YxC4NhhyzTFdd7ojHFhjbd0Un1AInTY71rufxIXEgYugJjAaNox
 CUc8bgnXCmP+twezxOYX+AbhLFIGYyc/aHIcCuBAjp38tg5lf29cUuERfWyKuwAGeyuo/SPupFK
 uzccw
X-Gm-Gg: AR+sD1098YB69Bzdv4tO3+f6/YELn0Mu242aCNcbgVdYj/yX5L69kp4JT/KoXaiTDMV
 zUWwrpp3fLtP1IIduDyz7mMB2vqTQ2oAQVHwCIzncxkDJD+G646qAR3Jg5SLPwlAIYDLUaffskg
 vcZ9Tt1rUxEwZPtoWeJ+nJS2Euc9iiErgadgsX2beYTq7ofW8qO5cGL+AB8ZCw8JjAXYPKpRAeG
 6P/gv/EieTU7IWJYUNQovk+f4r6k7YV+DL6m6zz0yWu9RJoPbcSWLe6KN2aO06MY/s4J40pLK1i
 xyRdEVNZpe3GjNZxIR1mwPnmM9T15Ky1fzNMZJYX9nSAlGzq42muNQ6sJkZ2cS1B5JV0sRYEcHl
 m1tcefWlCVOdanmyiq90ZtWns7QS9ipQtad5uRDMT4BIerUsKn3ExKnKaMlLA/cGaYJg9rQgKYb
 LDh711l9OVRyAuwarafRr+UtXXTNXvOFpTnFwbELTQKyI=
X-Received: by 2002:a05:6a20:3282:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c44b05145bmr7519892637.27.1784906930958; 
 Fri, 24 Jul 2026 08:28:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm45979954c88.2.2026.07.24.08.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:28:50 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:28:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/9] Complete removal of queue stats mapping
Message-ID: <20260724082848.2103bcf4@phoenix.local>
In-Reply-To: <CAJFAV8zvhZ0vys=_2xHa-MT-rHKwmxXmOGe9spoUikPU8zxZkw@mail.gmail.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
 <CAJFAV8zvhZ0vys=_2xHa-MT-rHKwmxXmOGe9spoUikPU8zxZkw@mail.gmail.com>
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

On Fri, 24 Jul 2026 09:42:09 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Do you have plans to remove this RTE_ETHDEV_QUEUE_STAT_CNTRS limit in
> the future?


No, that is much harder and has bigger impact.
