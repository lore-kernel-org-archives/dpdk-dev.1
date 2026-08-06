Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B43C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DB524027E;
	Thu,  6 Aug 2026 19:21:30 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 57A4E40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:21:29 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso3316783a12.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036889; cv=none;
 d=google.com; s=arc-20260327;
 b=HjSmXoFt0MwMqsbdsSUhT6wn6QviGZQ6oWTCNJQqtybQwigdq3yV4ORzkF5uk7IqMr
 NtiCi0/+cA1fZHTyIw7x9tDsuFQGGZOIVb+XjSnAJak5BUhLbpUhve9etHeI+ECXScyS
 RMC12MxYMpqgevxvpGwSSJSC0QN9pe+TM3J55LEDpimmxVEe2Xaq/oP9+ijextd2KXKz
 ABjpC0o7EFLxd1E2R2+ciFFTNp42VQxGzMP8XXg2AiZj0E7LaJYFQQAasBb4qKXRofnY
 pYTq/ZYfKjySNC6oPvajGN6/Ek974fLhJTPIgt0KoyInYFjP+MpEHd0lj8LSkAAQWecM
 Q8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hnDgKy+WJpdJuU1fYJWLqtFfD9KxSC8W1RaW8ME0iGE=;
 fh=wEzIXH0L3ZZv4NbN99MiwJpkuk4j833iCv9rKpOrsMY=;
 b=e279y4SGl7MEjOe9g6M79/LTS97aAS9DpBqvo8sLDavFBC9U5c6qmguih9h59ryLNP
 /QOqE8QJSDzpwguYrZQ6oO4NLT1kacJcB5w3uGrb84R63dSCMBkf8YYqMXodpqIw1JHv
 viYHob/5Y9m0ITguQJSousPZRxwhQXX9ECYQIrB0zL2UOeHTj2nbGaQI5WwmB3v6y/ek
 WOHsk8Gflfze+HLF0YvAre47XoI1lKFvrARDoXje428ZMLrnn5EaO1VEki8YtZjSweXy
 lUQq8yyOTmh79cR6MsyEbmvQTUfIHM1e2bFtaxqULy0bpNDyN//eoGf/NW1JUApmx2Jp
 2iwQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036889; x=1786641689; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hnDgKy+WJpdJuU1fYJWLqtFfD9KxSC8W1RaW8ME0iGE=;
 b=RhF74uc8uyw/nDh/qVE5VmFi246iaFXup2fI876bq7SP58uOnRtDyJyWCYr+2AER1a
 AkdljUJv+i6Wu9A/4O8kBIcQBniUqQW0Rua0TUFmmT/GPMKwgPTt+yLMB/ASkan9Pikt
 fKtFxU5sSoQXyix9C5hQqeyNUbHRIVaX0GN1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036889; x=1786641689;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hnDgKy+WJpdJuU1fYJWLqtFfD9KxSC8W1RaW8ME0iGE=;
 b=eUKDFTlvpdjypEdREY2MsfyJVwnBpVagyHrgoL0uBoe8N7N7M5pijsgg8jA6t66yVW
 BpOT5trrCp9Zo1Eyn+gGS0AfXvQjrfFNQ+5SwoCOLRtgSCv4K+gqiNPlCudk9mEr3dLf
 3zf0jKhQkNKckJqiwtkezND/22nKfWQKgOJzhMw31iTCELuTKckKGbGEwvvHQPMgHBEP
 GAXPvUfSJHivQebaA/RALUUN+F0kdt7JQYQF2bugFOjAwZ0mPotDoyB7avBINpHvg/CA
 WBlQWPewIpUpmZ4KZhKCaoXVVfh9z8EFpFtXEIioUpcoAo/AMreumnjkTbLl/p9gzYxa
 5QPQ==
X-Gm-Message-State: AOJu0YyFZg2d3nwHEVDvV9r+TRd2vD2UF6JFWJfPrS2kEdwDkLuM/kS4
 LQ6chQMpKcOv3xb1ukE2+XZ91xv5YtuopNTth0GcYTCHdQdkphdIlXF7YOmFCuEPhPq3O4j8u8W
 Nn9J7qEimbYFW6kqJzqKRLa/4/u8HwNU1R6OFniTZmkczjV4HBPUfTtg=
X-Gm-Gg: AR+sD13TeBzadFA+s5cLfaKJcuJA4k98z3dc/k1j8i2ZsG94fyJBdhQ1lDAg/6Dax7L
 B8JDwOC9w5aTfRrPThDOyYCKhMLfnKb+iqXKfzXHDMRjjhUOFfrC9MgGrHjh4av1SxSm4XqTO25
 DMLnf7kvNtqKywLZJjE7N4JDhU8v+W/RlN0Ar3Xw5epRgD+Or004MpETrrfEQe1P/pGZ5rEeDIT
 4ij071tKIrqu0mneTq0vmMsx7FBgPwbPgMfs0+0SfR6YIyIcKAY2WtVgP4oiQql/+/QfltKMx2e
 /x8f5eBznLbHUJEa5YHu5v2kP4AEB2neAqB7ehRTJcjepkVCr3Vpi9GxKSai
X-Received: by 2002:a05:6402:3215:b0:6a0:ffb0:273b with SMTP id
 4fb4d7f45d1cf-6a14f00169fmr9734818a12.0.1786036888180; Thu, 06 Aug 2026
 10:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-7-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-7-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:21:17 -0400
X-Gm-Features: AUfX_mwcTbw_MdGYnRnoKWBBns0GB6XLE72TJhyMTxnDENGGi_UiXlgdRQVpmro
Message-ID: <CABJ3N2XMvzn1nDjxHnWTwNn9aDqY60a0F-s4s-CR6=yfPfFfZQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] dmadev: fix incomplete configuration validation
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 Chengwen Feng <fengchengwen@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000046aaa90658641e00"
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

--00000000000046aaa90658641e00
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--00000000000046aaa90658641e00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfiles=C2=A0out, pleas=
e ignore.<br><br>Thanks,<br>Andrew Bailey</div>

--00000000000046aaa90658641e00--
