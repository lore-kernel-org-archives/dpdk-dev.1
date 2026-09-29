Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B38C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46D8040ED8;
	Tue, 29 Sep 2026 17:36:16 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 2239140679
 for <dev@dpdk.org>; Tue, 29 Sep 2026 17:36:14 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88103e47f72so3013800b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790696173;
 x=1791300973; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KKrAiIdZC6pGEMv8MNbAUpgyXkr+4weUDfj0Qj7r+EM=;
 b=RQccwLctHWJfD8cNaFMeexEU59NlOcJK2AaNpxyvrK6c2eeQN2wlXqhUonbjeimSVk
 F3RB7ENpmLgAJZM4zRD/lcgvXGdv6cibL3H2Hzd19RtuyDguWGWIWNsQKwaMmAzKwCJq
 8/L4IIo/oI7PETnQWbe7nI29bllQ9n6f0PSOHeAnd7HyHurmnFvFUAXKBeZDcSrWaMuR
 GUbgQnX7bMxJdgEsDabVbevG3bq2HS37RB9czrU7WtzTEgzNk9XXWiO+1jyO4ioI0H4S
 9xR9OFvkeeKOk5ujaH5YnVAw+cEjnyG/D6zPlfrXadSvqUZxxR28j/BEPCEsvyO91iic
 phpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696173; x=1791300973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KKrAiIdZC6pGEMv8MNbAUpgyXkr+4weUDfj0Qj7r+EM=;
 b=Od4IZfP9imdKbSeOoWXxP8maRa0Tfb9CzdECaPuxTMeZl7VnzRjQjnLW4pW4/zPOoo
 FL/Xi0PRue/y5xC/4QLGnnXO3/My7v+5ARRknXK4VcBsK1at7EZ5PY516TeKLIWGopYo
 ilHiQqYSHOhKoljmvhpA1xYi7LD2UOCwsWd/b9H66zitIuaaub/kcAcC2Wzc/10fDnsr
 qCi+8qB7r9B3ihPjTOlKfEQ0FDjHjhLN+kuksIypecRaPyCTtMLjx+YqqofCKrV7q9f6
 5/6FeUGbKJBy6vSlqEOk8RG+frCgBjrTPAg7RXT0BSSthsrJFJjATEar2uN9XVNZNZcH
 4tAA==
X-Gm-Message-State: AFuF++muA5aAy/ryedliBV/0CdXEuo/NxlOrmahakGqITuLW5tf6TUHj
 ywSjiBv5YV0IdoqPEA0Sh2sbb7S5UDdO0bootBVpExa2wV0JDcgFJ410ASsEZ7bvsJIo8aIGWfw
 Xt1FnIGg=
X-Gm-Gg: AYBFou33D4vulEVXpjPqwd7wolmONqNj2+d9M54jR5JYqMbvEcMnZ0cgQRR3eFlObGA
 7fp+qB332MWZ4jPPycCGjVEgH2/tRERhkIFCOhRQ+KWXcFLLOZeLPUC70X1C7ayMmGA86NDH63U
 MBTBk4NX8UyeP7mNuxTKOd5nKJdsBqyVVgxT0BB5lnQ8wxvjThp15cYM8548yYlOp5TOS8afybo
 p299r0FpdnvGJhUSbJcRMhW7qoJhZn+/HBjiPoByvsWqz+S0R890keUj54fqBdcY0q55lzhL8kq
 lAthKB7XqyOtW0hq1K198z3UE0Lxz19z0NbwdSFvPvyxOmmIo8x7kPFbiFSMbZ89LysDYYgqLoM
 foPTVljUJFru0tPHLae9vO/TizOOQdhYL5Y4dWY44tAzxCAFz04FOSZ3rEhgnx1u9VUKhFi6D33
 tdGL4Sf87P5Ms2jV4qrTJW1cMuAby4yUzgi9ZdY4wP229rQ7A3qekOXW9PTzRdOvOXICEAJ/pxe
 IFweFRROFSDVYWWkC9ZHuVzAMgssgJiFzcBu5gg
X-Received: by 2002:a05:6a00:909f:b0:882:23ce:f515 with SMTP id
 d2e1a72fcca58-88223cef818mr7334298b3a.33.1790696172936; 
 Tue, 29 Sep 2026 08:36:12 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868865fee5sm173065b3a.6.2026.09.29.08.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:36:12 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:36:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH 1/2] pcapng: revert use of reciprocal divide for timestamps
Message-ID: <20260929083608.1da61ca9@phoenix.local>
In-Reply-To: <20260927195015.78109-1-stephen@networkplumber.org>
References: <20260927195015.78109-1-stephen@networkplumber.org>
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

On Sun, 27 Sep 2026 12:50:14 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The use of recprocal divide caused in calculating timestamps
> caused overflow wraparound. This bug was introduced by confusion
> about bits, shift, and the test was too short to catch the
> problem.
> 
> Go back to just doing the divide which ends up faster on many
> than having to do 128 bit math on many CPU types.
> 
> This is not a pure git revert because there were other
> good things in that commit like handling earlier packets,
> and catching if TSC hz was zero.
> 
> Fixes: 4fc65615b274 ("pcapng: improve performance of timestamping")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Both applied to next-net
