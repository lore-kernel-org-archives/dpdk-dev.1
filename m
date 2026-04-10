Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90980F459EB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D2B04026C;
	Fri, 10 Apr 2026 16:56:47 +0200 (CEST)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45]) by mails.dpdk.org (Postfix) with ESMTP id 887E7400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:56:45 +0200 (CEST)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-6501547d7edso2339775d50.0
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775833005; cv=none;
 d=google.com; s=arc-20240605;
 b=GJwy1JhPBY6MU3GI0TRSaXSbtIS9X6KiQ6ulP7ylCopnUzKpX0uAEOIPbaP5uDStzP
 TDauvpoKmlKSZgP5qJUUnfbpE0gvObnp+frmIwbF7fqLOTQ7c68qbztL6LAAyK9wZAi3
 dCBRveJL78BJWDVN0wX4s/eER6gjXmYadLKBZnWDlbIims2K3HnMHeoM3W1rcx7YwpG/
 jEK/TKK/D6j5AOzkT9J5fdnLkmWBmQinFuaMH2Seubmfs2R7h6G+6A4a8x8rXJgRjlFL
 vTnXdVpWLWJFVN0rNLghSH0T8o5HQCw5ncbr19PJq9qi8HrfKWdST3sW6AzsUuWh/8V1
 pqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9M3vv50hGkaEefo76bFMlpyuahEBS4sjMn7mf8KJVeI=;
 fh=rOLOQ0z87NBfn3B90t3HIPPssnN0ETGCE+0j51KSQIQ=;
 b=cUs7bEbCbXPronEfLwPAHblaUXJKjMaLxgVegwxwY9zIM0thkljNAua/7bJ7lUliTn
 Vfm2HJLTfXA9rPV+ELIKjSKITIRRTw/Sbbrzjx/dxeVPxXs0Nluu8GqhNW1FujCT1BFB
 69mCL3NdNw4rw4RE3eMhTBhf1HfwslFONkyOqWKOtIHE0WCw7ru3R8xVeaILXmCvvq3g
 nX9Y3OgiTy5X+P5r7nrPd+4iQoWsQBcQVatpU4Hd7Uj02drUtT2ZKdhWVBruLtunMf0O
 +NdfOKLqrd51Xy6NjfPdJJkB0YPhMBAo2feFJwJRtTVov7KkLtFVWNMjWpVz0eGqwiOr
 U2+Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775833005; x=1776437805; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9M3vv50hGkaEefo76bFMlpyuahEBS4sjMn7mf8KJVeI=;
 b=WpeaTDnV64ca0qE86KbEXqMt8BmIow8OSv6QAfgCORv7I7WPzBoPISmO5JpSxZismb
 N5YdROQ0pEXaKh0RzOH7/YBKh1fVG2ysMfktvXif3xZeFZZ87kQssITPLOylwChkmBEz
 8tKiQ46B6hSUrfyQDSLIJZaOjdHj4Zh7jKa5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833005; x=1776437805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9M3vv50hGkaEefo76bFMlpyuahEBS4sjMn7mf8KJVeI=;
 b=WU7qa1VZfv+aDPKOyUiYrzG2EqKD0ZFlRpn0z91fFalxdAncSq15P01Ebyv0iU//pc
 hQGAyNmGz3clEODlucw0VVH+nVT9ChitsQ9uOaN07Dv/RCdSyPcSL45AvQYRmuCWPYnw
 Ymr66eYN7eQFt81vN+jmYAgoOASwGxQS5pR8QyttaFaHoH4GpgZbv3Ltpy6g9tv3g9tU
 vAL2wiV2BgQ12n4R1MOTDNw4zhHAmChztYClS5zgCPowvTWi6E1M2M2bjg6ZFC7jgKEJ
 jvBmtYq1Fys/85CVcXoV7rZX6rvjX5JhlpWA7KVk1EEDmC2Rmxg5qdIuAmXbfFecaaNm
 qt9A==
X-Gm-Message-State: AOJu0Yw6lnvzO6Zk23fdYX3kjuAmrSwoPfIJLXFtesJ0mYHo80U91gcB
 iGUKcPgIC0xFXj+m7DOvf3uwl8d8QS0uvzbWPoQ/1Bq6NF2A6U0nGNAuyuIB5H3XnCjZmjvgAyq
 yOtowc55YTxSU5Z129R2mPdUZoEsV7gSwTOE8VEvhmQ==
X-Gm-Gg: AeBDiev3Ak+2RpgHWCbH+cbj8Fo7GywHiqnQ4HO0++onDlXG1v/qxCGbNC/UUaCPSK+
 Hq0k7Vdjrz4CHAG8u/fpziDBfLAJ1D22UE8P/INee+xyJ0YLvaj7TWUiaXeFdoFiH+ot/pl5YNA
 0s9KSCYR7YuOeenh0uM1l3+n6aDEnyPg8lxqSM4cxHu9vFOKZ979+i5gLw9a8NkU0sW52bdP3n/
 VQ90XTxYZ9hqTIYaBbIKHlFpEjp8MWkYpZRaaRKDDwbZnQ6tci+b/Ej+X8ko8m0IB3Xd9aEPs4j
 WttstK8cnv88F6w/i9zZ
X-Received: by 2002:a05:690e:189:b0:650:1bff:6045 with SMTP id
 956f58d0204a3-65198bd2438mr2510764d50.54.1775833005042; Fri, 10 Apr 2026
 07:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260312203630.96473-1-dmarx@iol.unh.edu>
 <20260312203630.96473-2-dmarx@iol.unh.edu>
In-Reply-To: <20260312203630.96473-2-dmarx@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:56:33 -0400
X-Gm-Features: AQROBzDKYYqgjxmtfGQqaALMy4bSkqPe5GeVMRWKMpUyBETThG6koawtQ_k4wxo
Message-ID: <CABD7UXOEBUyTu=6cQ4v4SXmkGn_yoXVnXi_=g2v+dOjMqHGURg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: add VXLAN protocols to flow test suite
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Update on this patch:

This is fully functional and tested on a Mellanox CX7. It applies
cleanly on top of the merged flow suite, and can be merged pending any
extra reviews.
