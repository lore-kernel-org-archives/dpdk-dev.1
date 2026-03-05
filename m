Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE12F3D332
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:50:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7617A40A89;
	Thu,  5 Mar 2026 17:50:43 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id F353F4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:50:41 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12732e6a123so448315c88.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 08:50:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729441; cv=none;
 d=google.com; s=arc-20240605;
 b=XK+feYN3pKMTuReENAahmY3qUDqJ91KG7xE4MtrVUXygU1ORTf5w2aHj9kdGpni6AT
 7PoRfkdfeXndxWSkR2vZKcnqj5+UB3fPvjRkgW1HKxNORf0TsrXg9QWyMRUzS8IrJDve
 wYRdE06y2vPDh7m9CvP0S4c7Rznfglckz0H2UbAJBUlITJRkcS/WcEYEM9CJO+yNBFKr
 qdtscgPGHN47p4CTLsfz841s+lqxFbjN0ozS70qYhMpQTrs4VpwTFaVzMRXTm+xyozf6
 VEBOcxFmKQGaBfCSq6G0EYuz1Z3HPwfXSrHZ96QX3fLHv2t3zxLXhlVZT1fvHBITSYDd
 WAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uX6yVoQaujyAtc0B9PO7k9/PqfeC6FCP3rIm/gLNT4I=;
 fh=EmIcb+uVPOlPBF1BpgYQmLwFYQnXG5S0p2dyMBWTb1s=;
 b=XrTZvUfGzj/nyrwvLe2DCYwKM/eSBmEs4SH2k59Qsg1r1VfgtSUgHilsYqUTDqBr90
 pqT/jPcSyYQBKzDsfcPuEQ55zluZVJF2/YeJhRF2sdhYe+WIOWEYryOe5IRLv93D+lQQ
 Uue6PDO7WO1rX+5uv7jUuBqMTqArhU55nbgfKQotFspdSD78SdCs1mNE+HineGmbyMNP
 3EGeFcqNYBLdfCxnYQHeNqVUH9I9GEzXwm6OhHKwRGsI/KfJXeUp8Y3ekW4URHEcPlgy
 2ZpXi6tHLfyf4HJOGfkV9pnsoDsPUSVOdtCz78fx6BnkTyW327mNmTacwCc2kstrY1+a
 DL4g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772729441; x=1773334241; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uX6yVoQaujyAtc0B9PO7k9/PqfeC6FCP3rIm/gLNT4I=;
 b=azFeHibNkdbjmueRZDqOBYNMbju5wo9K8X/Cpgwp+6+xHYywIUXnsEf+tLma11TZCH
 59jpUj8Pl4V6ahOW/2XjA5A7JfWOW8hTh25tdM/k0+fcInwUX9kvOJdiygQtx/wQ/TvQ
 d4TjfiyE6oCF00xlvwAZC9yeT/SA6HdL6VEXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729441; x=1773334241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uX6yVoQaujyAtc0B9PO7k9/PqfeC6FCP3rIm/gLNT4I=;
 b=r4RSLjxQdxMwISk4/rwIdWga9ykZpO+oG9v6HWNoU1Qql30gYPukDcGUbsDYvW4pNT
 GZe8K80MAAJD0s60WYBAJ7ANMqAz3m9SGve86WeUT941L5MWtIYtBA+i1CuVb0Z5kAoA
 h8k5ZxPyAY+1xTeHutnEhSDAqBLNRd5ZkkLPjSeLDakdC2L32UkzbmuPNhHVWRi3dYmc
 v2sl9BWRdWGkTsKh5BKqoVc/Q8TaDgRie1evRJjfrFykAMRa5OH29PG2L5+YEdU5upCu
 KZhMikNw91xcCHZzQs9o8PeidqsC7+mhTvtz/rx9oEYFmOHLWN51PWgmN+/hyknyT+Db
 1fSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVjHwDwepb0ZaBY+UMftggek3NqiBckU4yYEIfeTXi3Bx0gf1N5j2TqJjgge83kxD1ACQ=@dpdk.org
X-Gm-Message-State: AOJu0YzTlnPRdxXtC6fNvO2M4yiRdgxNUtswb2MaZrEuZ8ZOAn+IAz3Y
 9ZKc2W31Y2dyRwQQhe/SOqh1DxfMBSfuHUrD+u2mNu7uw035O4Zzmp65sQhlCXiFIPbs4w0Kkkw
 4CH2yU2qd9y1bLtJ4lZa09IML8wYxdUgiQ1EC9pEDDQ==
X-Gm-Gg: ATEYQzzEgi8VE0p573HhCdRO7jmq6kNC8G0/eveS/T84nWrMt3ex4Do8qHfcqN0htGl
 V2MhkDdR6Yb7+wrX69KyoUawBXgzHdxYSU+2pUbxhKmrsGJcVo80IQMlJyQ7GGuXOCVgDadoxDW
 qy5n74omjdz810lQv88yaihEKVK4Y2sIP9e+VGTBAEux8JQVIeM9xjxhXkuSn4JgdlavfPqwUfz
 pd3gvL84qyacymQ3/9QZBQsFqCTtbGVt4VJE7ntv3hqq+0TZxhxa/EYYp/gOOmmhExBEh4E/dLT
 CYPPMF6KgVgZArLBE5jzVKMQ3DqrBhzGSW9kb1wJaPnjmTifVJEBwMuQA0bo2evKWYJYOmN2
X-Received: by 2002:a05:7022:2207:b0:127:3b1b:dcd with SMTP id
 a92af1059eb24-128b70d11a7mr2560325c88.23.1772729440823; Thu, 05 Mar 2026
 08:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20260303170136.509304-1-dmarx@iol.unh.edu>
 <20260303184131.514380-1-dmarx@iol.unh.edu>
In-Reply-To: <20260303184131.514380-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 5 Mar 2026 11:47:43 -0500
X-Gm-Features: AaiRm5009JDJRejShsE5k4T0wGXbbRtqBMfB3IdPum2j8iKCF62N28ZoZNER2mU
Message-ID: <CAJvnSUCYgph9OuFS7fWkyu6kLOqxoA7QZPjB51_XMZv-am7LMw@mail.gmail.com>
Subject: Re: [PATCH v4] dts: refactor flow suite with generator pattern
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

> -    @func_test
> -    def drop_action_IP(self) -> None:
> -        """Validate flow rules with drop actions and ethernet patterns.
> +                try:
> +                    verification_method = getattr(self, f"_verify_{test_case.verification_type}")
>
> -        Steps:
> -            * Create a list of packets to test, with a corresponding flow list.
> -            * Launch testpmd.
> -            * Create first flow rule in flow list.
> -            * Send first packet in packet list, capture verbose output.
> -            * Delete flow rule, repeat for all flows/packets.
> +                    if test_case.verification_type == "queue":
> +                        testpmd.set_verbose(level=8)
> +                        testpmd.start()
>
> -        Verify:
> -            * Packet is dropped.
> +                    verification_method(
> +                        packet=test_case.packet,
> +                        testpmd=testpmd,
> +                        **test_case.verification_params,
> +                    )

Is testpmd.start() only being called for queue tests, but not drop
tests? Do you need to pull the testpmd.start() outside of the "if
test_case.verification_type == "queue":" block?

>
> -        One packet will be sent as a confidence check, to ensure packets are being
> -        received under normal circumstances.
> -        """
> -        packet_list = [
> -            Ether() / IP(src="192.168.1.1") / Raw(load="xxxxx"),
> -            Ether() / IP(dst="192.168.1.1") / Raw(load="xxxxx"),
> -            Ether() / IP(ttl=64) / Raw(load="xxxxx"),
> -            Ether() / IPv6(src="2001:db8::1") / Raw(load="xxxxx"),
> -            Ether() / IPv6(dst="2001:db8::1") / Raw(load="xxxxx"),
> -            Ether() / IPv6() / UDP() / Raw(load="xxxxx"),
> -        ]
