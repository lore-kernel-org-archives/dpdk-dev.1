Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECDCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 20:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 196774028F;
	Thu, 18 Jun 2026 22:06:01 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 79F174028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 22:05:59 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30beab3af9eso3646054eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781813158;
 x=1782417958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeS/HesSc8ds8tYpO3OmCSsyHiXWN95swlpZ2j/Z+9o=;
 b=TlxA01+WNfZ84O5LNKWaTV3Js4s4arT/ZPl65O468vbZKmhgfEhmTiZ0LVcpeo+Lw9
 l/4mvCJhI0H33Eswi9x/u09fa/pH2Sp6ivyHlsmSUZJTrOmTbDr8jeKjy4I1e09FbqyN
 69jxVqUWJoKeyxGRkmJVjo3pngUVKdoKqrYkYrLZAmoRppT8q4esrqckibEWIt41Vvye
 fiNcbKfswbrcjqbPvz192KscojWJKyOdTgs0TNkZYzwX9T71IGX656KngJtvWfuwrOyV
 F4eWO7HLHAC0AbI+vdjusHJkQ/TrHQ/lbByy3wi1gzdDsJvYdCfQbwhOmuMNcxKYiZ40
 +GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781813158; x=1782417958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EeS/HesSc8ds8tYpO3OmCSsyHiXWN95swlpZ2j/Z+9o=;
 b=c7guLT/WeySMaVjDcP1kxwCvTrdzkcWzSt9y57HDiiyzwS8XdTIuJi/krOw1qHluOj
 VahqWTlfpL8C4Rt1Lo0tfkL9fFE7WAXV3mvt/gMJeJh5A+TnQjGgzDKxUXtmcvBZcNKh
 9KyFwC1BllV69nAWjpfOsuFhCAHnLE183aJFVF0fhLsWAM/DRsjp2FUR5zeArdODra7L
 cWY1YPPlD8bcN8g3kgf//uJ7NaHNiIFfrX4xm703nzfemMEnkQX2sMbd530fT0+u3LIv
 uXpEFckXQsA0BzyUCByJEuV3C/foWYumvUohL7XaKa6HQzcUvHMAnRqbYIcydwxJCrxf
 zgqw==
X-Gm-Message-State: AOJu0Yz6T3sHTuuJo7K3pt4+421iUAO8HNWjco22dL0OwPrqYRm+Fs6J
 XKuj2qme5mX/a6HeeJYRjMrPbDaFQ2J0Gm5j0V/yQhzyvu0lxuRPqAzdpeiclx1Oy0E=
X-Gm-Gg: AfdE7cn5p3bjgwiZnejkCfrjkZBGzDMKE3Qw6/PnbpdQ1EX1CjFuy5cBt6mwqSN4/+u
 zoHVjMPNub4QVV/yq98Sz66XKv978f2hDOgGktDtF7AQfNGnwMdbW9gqPLxcEnIvOinpxchEj9U
 NBiAjFDdXQK5+42RS75oQkHaFgyjNPu5yGZ9F2sTl7fjKgk4V0Dtyp7TyoKXHwW+boyxMmM6+oj
 0/73zji2q9AaG7wVQP3a91UCFwvkq8uIpjCtYasgblQlWoqgGadXhx47AO3vdhqKbomFqxmILt5
 C4TgTH4SpxowXm8rrvI1xhq7iuAVPBBFjk2Xo4C9o1Drv3VD4dIs+35hqxxG4m5rnzRXIjMyRCp
 EzD3ICM4+M8wQmoH8Y4hAviKjuRxG1Idl2C75dgvwHEruOM/Y16KtBA9CF6GQKq/4aPM8mv0be4
 ftVr0H4337SCzuEF/NG8kK5WT/hdsXrY7M4S1vUYHcN7u8aw4Y0Zrtew==
X-Received: by 2002:a05:7301:408c:b0:30b:c502:23d9 with SMTP id
 5a478bee46e88-30c07006689mr730379eec.16.1781813158370; 
 Thu, 18 Jun 2026 13:05:58 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c0670c253sm423959eec.10.2026.06.18.13.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 13:05:58 -0700 (PDT)
Date: Thu, 18 Jun 2026 13:05:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: Re: [PATCH] examples/ptp_tap_relay_sw: forbid shadowed variables
Message-ID: <20260618130554.616501bd@phoenix.local>
In-Reply-To: <20260618142526.191340-1-thomas@monjalon.net>
References: <20260618142526.191340-1-thomas@monjalon.net>
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

On Thu, 18 Jun 2026 16:25:26 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> By removing the compilation flag no_shadow_cflag,
> it becomes forbidden to shadow a variable.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Thanks, example did not exist when the first pass was done.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
