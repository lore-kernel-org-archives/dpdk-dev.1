Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471B606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=compilex.com header.i=@compilex.com header.a=rsa-sha256 header.s=google header.b=HltVN2iC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCBD94027A;
	Mon, 23 Nov 2026 13:57:09 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 6493B400D7
 for <dev@dpdk.org>; Sat, 21 Nov 2026 01:42:59 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3b0d0b80fb9so1058427a91.1
 for <dev@dpdk.org>; Fri, 20 Nov 2026 16:42:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795221778; cv=none;
 d=google.com; s=arc-20260327;
 b=kwAvHTdDs9/84NpJMbYBoD0HCM2dICgh17dzaovDCWc+HhUEelld8JI7omlt+vzp8t
 ZIggadHOZHk9y1n9OueXZfluVo9n2iHyYpJ9gFbNRwR5nEfKsTqdT23CWfG9B6GrAr+s
 c0vwJOnlCFxHPg6ErBB8rvQBDQiFLZLRERySRI5yvQpghIq005SS++H5HL/vRZTtglIA
 L7o2iiEJGLodxEXG1Fqi898zgqP9EFiv8fnz8RaxBXuDJ+wZaxdYYBPkK0HTUC5S8fWG
 sY3tUYGFXng3EDAfVQjUo5b9gqXzgoWi459fqU8ceTTMRrDM0ipAH6jkQ45y0Ky64i3u
 aXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=KV0PXI+pafCQCM+DSeEzLgAaI6xxPwP6IfmuollG3QY=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=dyLBB9x8OqLOcBZdln0CS1U8jenbh8rEKMRCkDjJ7mmq6ZSvnVlXfY3UlQw9Vdmc2U
 +VpPMsdwe1Tg3XRnhye70lvwOqenpXHOt/tffOYoWkPBMve/3hs/dMZ7puCDZuovB0/9
 82he2IWRNp/glePeEQlliZtlTX1RYAEXk89lKoaO5CRoZzrt3CowaO5I9ywP/uvQPGro
 0VQ3UwGPmqlXH6x/kLNkBeHH+i9YbSkcCSc2EVWBIgHgGXeiXeR2tc3/dE4STvUViXRt
 TadvPUkoZNskH8wK+GhQK0YtF3A57lWcvubt3RvwJ4sam/N3hUKgQFohySax290xiK13
 SQsg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compilex.com; s=google; t=1795221777; x=1795826577; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KV0PXI+pafCQCM+DSeEzLgAaI6xxPwP6IfmuollG3QY=;
 b=HltVN2iCwYmAaCNGINUdjoRFRJbTFzUASZZfbsFVaPE+DIol8BddHqsltlodr7dQe4
 c0mwS0Wn8C4zSRSkXg83O3H5mQF/vZGOJpXVC6csLYeIRNixHiqIvaHZZt7IrxpMNs84
 mTR/GXDTGRKRqYCOXw/2mbcNyRVtVG4xPu5PhFbJyS3wGFd7HDFRxXKCXC2F9dToM3an
 4GztO3eUyxwB+KIvEJGEC4HNSYZYMCZ6ajBcIAoqi8lLep4NbB2dgVUmJ88Nfxy/y1o2
 fbugXVxRiLmUGoN4CmV2q3hV+yFVyo69awnH3Fm5ZsdXug/QHHbgwKfWwBcj2ogANUCA
 osdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795221778; x=1795826578;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KV0PXI+pafCQCM+DSeEzLgAaI6xxPwP6IfmuollG3QY=;
 b=uDOCe12eY09PuFbwy93bZwnwseTJk7aDYxuSCD6f9kkHL4WcZiLNFhD72XZAgxThP/
 lM/nej7Yc4xRmAPOFbHhQp+1Uru7DjsNPpsbhGnGyOhVP3nksonTa5tp9IXox5Pu8LkN
 P3edMToqPrMXHiLs5zrerq8/HTAoqVaB0ZWG2h2F2wxOFR0zT3yxM2kFn4yvr2aWz0+G
 U09spEVDhP3b6IUWoAlAfmSbrORSMQWU+/qNrd8I4yIKLqoi3b066nhxWx8hu+e8T/JI
 IMSIimt5zSai+78DpWdDVLNu9VIawww3vw6Gj4wX3c8kIaB3a4/KCfV3e/9NWuAIkiUL
 lBBA==
X-Gm-Message-State: APuU4Z/FicbX2uMq6v+95tMrd2erFFlmWXXXk8wkFMYJeqHmEOqNyUaE
 Ci7KoT4RkumZI5/IhsFvrMxriPHakzUkO94hqsJZYEekzNTsoQBdXBg7dsD5U9VK+5WDtblGR8+
 IyzcR4sPQUxjC27XDenZJ3DsbPd3hg2sebA8cziVRETNa4baIi2VH18xIYg==
X-Gm-Gg: AZFdTZePhRHM0NOGFmbbrzkS0SeqDj/Vx94aFXBN9Drg44ApyWZjrZ1zUuc0yzynnW9
 z6wpUqBPmmeqKVtypl+lEcp97inEMv9ZbEKp+uvTyZnyJMtNcRmlADA6FBT6VYa8pONUDr6T7v1
 /QbKMEH3Mo9C52kbrCtdZOZIrbEPMbldEsIY78q2rvjL0ooiTKUArG134xkqw282WspxxIWjof/
 +c/Km3vpFfPsNG/Ke7qhZ5O0NgI541AqzZAlzqz3e1hjt69Y5VayXzigybJvVMaCp5Hgdj3uxUw
 HQSUFr4IezyGJRguDDfC3fU+T9Mb6JZ2pTNl5Hmfc965K3u4/aaZPOt5XeQcn6VoSjSS0nagBlh
 ZI76S9uq1FJr+xFhEcC8zw0ncjseSH3jStRp2A7ydo9LEVi2wURtqruI+5ghsfngikrosEan3AL
 y/JaugVjPX5qqYi1DFLPzqbwBul3PiR98GW6HexZ/ieWRmqO7sQu3xARWkrihLXj1Pso3LJNTH6
 KwEkWen1Djq/Y/d4Hg5b8EidMGmbdnZoOYX
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2d8a:b0:3ab:413:49b6 with SMTP id
 98e67ed59e1d1-3b41c952eefmr4523142a91.41.1795221777440; Fri, 20 Nov 2026
 16:42:57 -0800 (PST)
Received: from 338689075775 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 18:42:55 -0600
From: Tony U <tony@compilex.com>
Date: Fri, 20 Nov 2026 18:42:55 -0600
X-Gm-Features: AclHuK8LT48ayvvFWn6qIPWJN-2ZLGDNVsQ_vE9_WCZ20zxlq-cruBQ_ClH28cY
Message-ID: <CAKFW=BgmYZLVcwHyCijQnQtCg2cFDT04r1Yzi9AoGLOgSGGe-A@mail.gmail.com>
Subject: Re: [PATCH] raw/ntb: fix Tx of incomplete packets
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005671bb0660bea4a1"
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:57:08 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005671bb0660bea4a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

Thanks for the fix, and for the Reported-by tag. One small request before
it merges: could the credit read *EZO Labs Security* rather than my
personal name? We file everything under the company name, and the commit
line is what the stable backports will carry into 25.11.

Whatever form you prefer in the trailer, the name to use is EZO Labs
Security (https://ezolabs.net).

Thanks again =E2=80=94 the behaviour you describe is exactly what we measur=
ed on
26.11-rc3, rc4 and main.

EZO Labs Security / https://ezolabs.net / tony@ezolabs.net

--0000000000005671bb0660bea4a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi Bruce,</p><p>Thanks for the fix, and for the Reported-by tag. One sma=
ll request before it merges: could the credit read <strong>EZO Labs Securit=
y</strong> rather than my personal name? We file everything under the compa=
ny name, and the commit line is what the stable backports will carry into 2=
5.11.</p><p>Whatever form you prefer in the trailer, the name to use is EZO=
 Labs Security (<a href=3D"https://ezolabs.net">https://ezolabs.net</a>).</=
p><p>Thanks again =E2=80=94 the behaviour you describe is exactly what we m=
easured on 26.11-rc3, rc4 and main.</p><p>EZO Labs Security / <a href=3D"ht=
tps://ezolabs.net">https://ezolabs.net</a> / <a href=3D"mailto:tony@ezolabs=
.net">tony@ezolabs.net</a></p>

--0000000000005671bb0660bea4a1--
