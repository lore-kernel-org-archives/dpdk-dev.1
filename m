Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E79E9D812
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 16:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3AFE40616;
	Sun,  5 Apr 2026 18:48:28 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 26EBA402D8
 for <dev@dpdk.org>; Sun,  5 Apr 2026 18:48:26 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1274204434bso3413686c88.1
 for <dev@dpdk.org>; Sun, 05 Apr 2026 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775407705;
 x=1776012505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjYDDfop4CpApvRYk405ueb3BU49gMx1ej62wbhsZYk=;
 b=ySJurJyjBujQpJs3wOF7n7dbfwkF6j20jsdFwFcMCZMowWMceBhG2vUor/SBtHtNTt
 IrG/mki594JGBKKtaHjhxPYQEb86SRjwqPEl89xlrgPuR8NERztRQFO3NSNi9GZyBFMU
 8HOrRs8u1JkR1yGSdCoxM8dbta/j6nkE25QZWAfoF0JDYk7947HTeykfrs4+1IqJFqwN
 Tm78/DI4Ei5qKia6JHu8DEZOJi7NzTOslILsCovzNtnV5SZ7gAbBeVpT20LaQoieKQJ1
 gba1mxII5IIW9YDx1QQ56+9lx8DBKopaNR56Yougr7P9ROBsEQxdekJIYy0X1Q+BfSRT
 nsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775407705; x=1776012505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jjYDDfop4CpApvRYk405ueb3BU49gMx1ej62wbhsZYk=;
 b=aGNCtlPIwIakN4Qdkmxu+EEfEjYA/2lpUNQZp7cWfR5mzj8TnR/VZMrAgbTtQavVsC
 uDWGi+233vphdIM+XdoJxRrReBOI7YzBn548V4x+oOayCEPC4I2M7dcX8sOfK9r4rRng
 tU2PIc0O4YHMKTiX38wvoBQtPZKNAa14MtT0LWiv9L1TNGP21Mm7hkOf58NIjLI+LCcb
 eDWuNm8Qh270UhNbplKFopjVRdK0fna9PDaWXc0p1TAhoJrbcm0UVLlNt2XErQR9mEnn
 IwK8SlpBtjwLlNkREBg5y0UuJMT65mAiLxqLU2TOBhReDyOIkfakTKxb0hnCNhXnAXT9
 mxOA==
X-Gm-Message-State: AOJu0Yyj86QtHmS3mURLibPt2yySJo6oUFELzXJfN8md3ukjUF2AIRlq
 H05WuCHJFHwZafCOMjNnhzj2CvSIIj7xJpm+YN6RFup2vI+Q8pjBGrehuJ9F5zc5J5w=
X-Gm-Gg: AeBDieuLBtJgiTRc+Z41wjW6mM1tlOMy/NMon/jBndf1lmy3kJIiXcm9S5ZcsdAq3jz
 Nl94yb8PDq1VLyLWWge3z1pxyHYPrxlJMPcR9vPPFUKRIuka9FLjtKD9fWOG2uSl49+GnF6zUab
 3ojt+tBwO3Jn0XVVpG6q/Nun9kYCST9sCwL/OBskFhqnRVo033O2pIcL1s/OVPrhQjvsOr2SDfF
 /0UgGhiOz/M3IMDbfhP9VuHPHBiEUyNdTv9ALDykbe2lUcmHitUh2uQu2vFY8gk2VypBSjzB/J4
 yIl3/NCUvQDcNV/KWCGyJinWgKrtOKs4KRafrL0rxTagEm5g+F84YnrSqGZxbThN6/ylnSK5ymh
 k8MHCrFjib4qbFHssS2EbGHAXVlWcjaAlJjWpB4bdgWD8ynE8Mvs0ZJGeC3h7kOQo4FpwAC0Z+m
 JWusGJrTG+Z84ofGHVf967Tlbu1AouS+9jmHw=
X-Received: by 2002:a05:7022:e01:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-12bf07d3a59mr5035409c88.11.1775407705116; 
 Sun, 05 Apr 2026 09:48:25 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bedd70f18sm9558217c88.6.2026.04.05.09.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 09:48:24 -0700 (PDT)
Date: Sun, 5 Apr 2026 09:22:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 2/3] cmdline: add floating point support
Message-ID: <20260405092225.5ff607f0@phoenix.local>
In-Reply-To: <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
References: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 26 Feb 2026 16:44:49 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Add support for parsing floating point numbers in cmdline library, as well
> as unit tests for the new functionality. Use C library for parsing.
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---


Some things AI spotted that I missed.

[PATCH v12 2/3] cmdline: add floating point support
Error: In float_valid_strs[], the entry {"-2E308", HUGE_VAL} has the wrong =
sign=20
=E2=80=94 it should be {"-2E308", -HUGE_VAL}.=20
The preceding entry {"-2e308", -HUGE_VAL} has the correct sign. This is a c=
opy-paste bug.

Warning: In cmdline_parse_num(), the float write path uses=20
if (res && write_float(num_data.type, res, dres)) without the < 0 compariso=
n,
while the integer path uses if (res && write_num(num_data.type, res, uintre=
s) < 0).=20
The bare truthiness check happens to work because -1 is truthy in C,
but it's inconsistent and fragile =E2=80=94 if write_float ever returns a p=
ositive error code, this breaks.=20
Should be write_float(...) < 0 to match write_num.
