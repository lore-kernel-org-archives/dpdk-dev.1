Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973F1099B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 21:13:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7C4402BB;
	Fri, 20 Mar 2026 22:13:07 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id CAB80402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 22:13:05 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so1214188c88.1
 for <dev@dpdk.org>; Fri, 20 Mar 2026 14:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774041185; cv=none;
 d=google.com; s=arc-20240605;
 b=b1Xbjtj48f1t7mYPFvnE8xCumxguZn+XH3aPWK5yCHKpMytZnS1YBF92ohUpYEmWZy
 gxO9cEZLrLNfVWvi4V/ugxGjH9wSRQXKddFcLw+0CTTtoitG5Vt9y+oc/g8w/fo6zVoq
 gxaoFxSE6Bj7V+URV7GMol7Ge8x/zj5MY/DuKWDhyMNV3u6PmquksxobrzvWoh17KLrU
 6rfi4HFD6zoeiKlSCI5Sxey8TY7zCXtsP3CcSIrlK+FAQsZjeiePt6d1/85MJs2kVFhF
 sqj815jHgCsnvNWzTwqzK0j6e4vYQl/e2VvHq0bD1FcWIkjpssQTH+LpCVKmQU/e5RTK
 Jxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5OrcX6p+2eKOId/UkuVcqQwAiKVMalyFl7dWO/2BkC0=;
 fh=IpSuibxUyYpvp4DUFjLk71O5fc0V8hVc2GR2wu5nWVI=;
 b=S2qok6ROOinYW8/zLxOSTalh0nuOhNzkiKUpzXpgty1Q+bigiuIXRTb36lEK3d8mdN
 rEq4pGID8MqOBo9Ej4J+xRRH2l/Gh9XlSOfEx2Zrdof+09x5I4+kwRgiMeCvQLk2BEcD
 1na27RP5V9PgiGcO54Oz716XqrRojqkekNIScWbGx1QANwUGCgt5DlHEhTALVM1yc7Ir
 cc+I+9MY64dXUDplllOqWgaJlLiKi+rzGpqYnn35sd++Xjg+3CiDudmYhDt/RbSkGAch
 6sQ46z4BkImXZQf8xtBXNUj5eSIgKgP9Vu0WIgrOJTFqD0ZwzK+/EsxHKDjrdJ0y7zfs
 QHCQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774041185; x=1774645985; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5OrcX6p+2eKOId/UkuVcqQwAiKVMalyFl7dWO/2BkC0=;
 b=buxtYbjdhuNSqW52B3bPzoM9F/puem+eXfW7EkRfCqeZ0pUrJfHrzNixERORLr5NFm
 O6RTSxfD3WPeOsmWK2coXaQoOKCrFFQ+6LCE9La7vXykIFT5Ry+EWU0eSAT3MfxPw62A
 K5yHt2MALO5bIt+/tyJTxFK133oCbs71h8sX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774041185; x=1774645985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OrcX6p+2eKOId/UkuVcqQwAiKVMalyFl7dWO/2BkC0=;
 b=D2wfBlojWg40+5zv4pO1Iupw691VMEOmBlmoC7k9n0xYQU4Oyq8I93VNtLvyzvJOM5
 LPfU2MLU+99FsUj1HLdjvC4INA2Q7Du/RTz4HjxOyrEdaWVBn4XpNpGhiZy4yyTqk9Lt
 R2j/YLEb7k3DP1H6fGWN63vYRZObGWhvtspnEDNjcGljJB0ScPV09tNV9SsqMnBMViJr
 BQIZnYEIBdqYhBIqrhJveZzoJggcxeYwmPN07oHpN6uhqyOxCRxd4PpOQwKxgKzB6nyN
 9PktOTVXuQQOi5xNKZDfBTQHQOVw4iEV+Y5AF0zVwcER61ob0pVb1ixJMmvOHpE9/MFP
 BpGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOW+IJe9Fib2qPVEuS9X8kDpVPVGmFP2caMAPY7UXBCbzXNKxyRwrlOGsZvQVriGUxrHA=@dpdk.org
X-Gm-Message-State: AOJu0Yy+n3JxVmax1CG9V4iwNkIrD1SJNhgzksLFmhcszRuSpXzZoho5
 BsWgPp8O7i7Pe7wKkqYDNPuHY7VtrL800RrYL3U92lO3Ve95u3osUb2sS1iBUEj3q8P6gbz1Pm4
 YOUbHNiXXVpIY6BJjc0xl4tITwtKRUAEPoQqBsO1lhQ==
X-Gm-Gg: ATEYQzxJFLImvT5qrCWR9Y16FPXG+CTTRRg1rlQEr+gz6nqW/d2/yYXq4Bj4OPjqC6L
 JOGOvp/daIKbOJJrt8e1hgOO7QiIVpB8GmDkNJX3lIPtEFWSNXup3YMDhOdV5KvVV9II2r0bqyY
 Fz0Lk1ey4TBN/TbeTz0tKAfFnrHPlKjp6PUbLJ1ICL9N3+0CbKZDygLh9mjIMT/qj0MxGnO/v9K
 hPd49teb2OCY8c3OdqN5uxyCZEx3GjCxwMAh5DBgySFIg+P+BAErckAabvdKgOz5Z8KeCVX+1I9
 LAfJWIBlMU3bm++3oBX+2y2M1ZQwGkh8qrDAFoe/YjbzdRRqPDNEzQ==
X-Received: by 2002:a05:7022:ec17:b0:12a:6f8b:36a3 with SMTP id
 a92af1059eb24-12a7267d886mr1740562c88.6.1774041184710; Fri, 20 Mar 2026
 14:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260320154641.21334-1-dmarx@iol.unh.edu>
 <20260320182126.35724-1-dmarx@iol.unh.edu>
In-Reply-To: <20260320182126.35724-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 20 Mar 2026 17:09:52 -0400
X-Gm-Features: AaiRm52IvmiSVoa7LeFCF6Q3xJIyXFpg-ASPf5nj2UplhIpXJqfghnmWQKNAAU4
Message-ID: <CAJvnSUCriN_i6wMgSBRifRM1rpZaDyV6tEk8Ve149vnt_FhP0g@mail.gmail.com>
Subject: Re: [PATCH v4] dts: update overall result pass/skip logic
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Andrew Bailey <abailey@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000a1bf2a064d7b26eb"
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

--000000000000a1bf2a064d7b26eb
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000a1bf2a064d7b26eb
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000a1bf2a064d7b26eb--
