Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F5DC5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F09A44027E;
	Thu,  6 Aug 2026 19:19:34 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id A46A340262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:19:33 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so3482036a12.0
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036773; cv=none;
 d=google.com; s=arc-20260327;
 b=qEPc998hUkmCioQ7h9Z+kYVzfEZIhF6JCCrEoH1HBHxQHS7Ws4dY5qWTGdWUZhsRwT
 sQh+C6s2ZKJFFjgLJHRTEPW/lkEYRlzns3ihpCPqNxRoV53fBTiJHYlzfXu3L0ZQr7RJ
 h/bR5T7C+0NHjNf058JsjIiEhUZWUdl8XxRwzPXeiH5FVKODZ4C473Qu7l9rbOVcR174
 TTkceDhSYw+y7tJUZK/K0BfzkFVHZAgfyi9QMk0HEFSPelyomk0e/Fel8EplHTSE4aY3
 o4NdOuSUZoZdqehKOFzkwnD09Epk2T6vkOqmjDMSMzr4boTavoiziiaZRQVyDlvR6HTa
 8HaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IKUCC48k3G9fc//ojdtz8m/2nHpNZLGCwJNCtVJhfko=;
 fh=8NFLu/qH+uG/uIwiD/cCofpvhzLvwSzaJE4CYPqpxig=;
 b=HNHsio/Q3T5bFhdY34pM4pqZZGpc93RUYKUJYZTqYBnb+xjQL0w4C48lzmIX7xjYwm
 /oYZR3DnE4GafHmVLYL543HdSbfh6utRUJndi7I4hbAH+UuXd8L97bzfi6tNx6jHAy2H
 nZfopScWEVwj/+6q6MQ3am06y2/6FzCbcamQNcIWViH+gNZn++Pxtf6o2lXWc1Ez1HHN
 nt9iIv5XJBLI7reAAnl0QVuii4x7SUwL+9ARhKX2ldbtsbPmcgt0FH1zQLlE0anBGw5u
 O3+tZCzUv/of8opTGKfgj8cZKJJuH6PS7mIhrfDqZHwbiNeEemM+IlbbTHtGyZfhxE3x
 clKQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036773; x=1786641573; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IKUCC48k3G9fc//ojdtz8m/2nHpNZLGCwJNCtVJhfko=;
 b=Qdnp/JGTwqZOHZBfmmze6/uc9JbZ9BbnLPw362YPuquCCEeX7MXeB2vgvKSTV2wXXk
 9SOceKemQZd8Xf9NTouU4p2GCDjDGcwtYzj10+3PmuNoTJlcbrbvTET0hzAv/OyQTtEM
 DMiXiJ3nxyLESS5xsRGpplykfVxK4w5H25CZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036773; x=1786641573;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IKUCC48k3G9fc//ojdtz8m/2nHpNZLGCwJNCtVJhfko=;
 b=dleVVWLzg7ln0A8B29aU0sH5cOUM57EdCsmad3sxZIyQn2B1i8gC9wtY4UvOjlGk52
 IAJTjNQ5cRmI3lDR1a57ITKpBmPdiLDqZ8IxdfMyVQk8I/G48DLWQtrFcYy+pcWuSDaM
 yxTFU62afZ01zgaC4rRlL14zfGWtfcD/An1RvZ18FW5QfDmnNn1Le8xF7fmCrflDr1H6
 EdVKmOm2rDS48ozV8yFP62lnUvB8K3WzSZOUh7/LG7Gps25yi69g9yUdKkTq3cH7vqc5
 wP78vGNB8T5goZkD5ur3/8x2+bZJGmZvHGnKdN5VB9yj+8ewGJkqaHDqecKwpDepeYnq
 2zAw==
X-Gm-Message-State: AOJu0YzjWFcERY+Sw+Okstx5d0x2i2wh1J9CEuU5Mw6L0IikldmnSVcB
 XNOIAWTa2Xa6c7+TTd3hkHyX06polByZ+sjJw/y5TpnlxRgnQM8gIyTCFgS5xg8fZIsYPH+/J0f
 wz56Hs4uEtb0G9RycOMKdQmACibqiSgAp/GujwHfxfaWsEf528rSn
X-Gm-Gg: AR+sD13aJabv5Db+5RyMkiXXdAHqaAvJXZA0Wata3Nan7MIO1nOa6u2I3aYmsKVFbTn
 n7VleZc9XovC5xWCpLI0JdQb+bljVGvXH1YKeO6ZiFAv2Scfbe7zcy2O1qNloJzqRmc0zNn1xhL
 SXliWxtbe6Saclfz0Ce7Qj9vNFkx3nY7utvzm6WDsvlaENA27B9VX68u08poR7DZxP924MWrkYE
 93bFVawX8EvbVOOUr1HkrSUmQgvnpob1v6Q7vcz2t0yj+fkAcWnLWwqdO56oWgF1ZKCgPsWJotc
 bSzc1OBxB6Sj31x2h7329Jb8Gl9a4+6vV61HbmGzMox9/25Ybz6MrsN6I+Q6
X-Received: by 2002:a05:6402:a0c2:b0:6a1:8d3e:ee67 with SMTP id
 4fb4d7f45d1cf-6a18d3ef0c6mr5936515a12.4.1786036773326; Thu, 06 Aug 2026
 10:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-2-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-2-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:19:22 -0400
X-Gm-Features: AUfX_mzqLMYhpComBSlGtUcXkI9ONsTsCwEuDkGX2ni-L3PSml6PhKjFPJQuUaw
Message-ID: <CABJ3N2Ui1vhwGgj6K4aZ+r7t8H+G3pe=-rjTNyx_sdsMbN0HMQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] doc: improve 26.07 release notes
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="0000000000006e1fab065864176b"
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

--0000000000006e1fab065864176b
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--0000000000006e1fab065864176b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfile=
s=C2=A0out, please ignore.<br><br>Thanks,<br>Andrew Bailey</div></div>

--0000000000006e1fab065864176b--
