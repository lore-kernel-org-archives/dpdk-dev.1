Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744CDF47CB6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 18:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60C74402CC;
	Thu,  5 Mar 2026 19:59:12 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id 2E03C4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 19:59:11 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b935a74b7c2so1147010066b.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 10:59:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772737151; cv=none;
 d=google.com; s=arc-20240605;
 b=AcrxazCTAQa0EAeTQXYdTo+8X/X8ziwnWtvswoKH4jtzvKcF8xB6CjcouZAoWsIB70
 35IFit/dQkkMpc84uxOVCz8Gi8NaHdDnIyYkGmRwNHs3Mc55NK2idbLXETm/8VwliZW5
 dklSOiiPaZoB9gXdwcwOghc2vkX8b02ZmZgCi4ooKe/LOsK5QEQ4noh1nbH43d4erD+R
 jho0SSDgS0NNIUy7rIn7FGXLsdnXRpH5+55rczMfXoq+W5m9IpMRXd2r9aIvt08whfpN
 tss1UZLdYqNTJ7idxRwOSbKikw6l/1H+PCDOzEB+XEC7d6gjT3QCquIInlzIScrI3SFn
 wLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nuf3iNIv2RxDa/1WhJutdRt/Il2CVgVI6LATpmMszt4=;
 fh=GzdJHesa+H6OYugQrSBn4ZxfBzIgpJDKEpBYRaGMnUM=;
 b=kpJDg81piwnpG4ty58b7/W/LSY/9YQV5++HRXpS93qIhQG/j3GZNcmtnJaxl4UT0iA
 zgvt5Mt9WDhsVEPfcbRa/dZRuDnO675VvVo2wUwqd7XGXfcmZoDQ3GgW7q17MbDMlMjs
 GrI3dg26ahcZe/jMlueCMFUKiUScc5ekfYwZsdaVGJ4yvgZPnHyzyc+E+ZQ4WrDDGXhu
 qXUVscUtYbYYdFM0hBZrLo7X2iga7C6j5kP8hCA3IofYqjLES7VVT8oYr1/Qn2rwdg8M
 EA51Lb8/XVlh2v0HT1rnJcJe8K3rY38/4A40IbmfEMu0/MgX6ZmDj2545rpakxeU0ctu
 Olug==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772737151; x=1773341951; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nuf3iNIv2RxDa/1WhJutdRt/Il2CVgVI6LATpmMszt4=;
 b=AwLcm/snUo9nNI/8KTT/BBlkF4/I3lIU1VYEkkwvKKgMEuwdfkKGj9fw6o+IABB+kB
 gnlgKjwgLX5WPCaqX0auO0YYtrKbmVWPP0k9EvNXg5zsdalik8RwaSwc/11pqADJiJ1I
 QY5w4LW4xXQYjVYDoo9RVYmmPEa8lwhjtEzf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772737151; x=1773341951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuf3iNIv2RxDa/1WhJutdRt/Il2CVgVI6LATpmMszt4=;
 b=rq//0a3t06R6vtf89AkxJn1TbEE1BFuLieqrFpD3iA1y32G1Gh5OVqjZ63wR3kvXhp
 rnJPxXgD7R7RVOshd8/hSFGP4V4ZMGFptyB1eu0te6CuWzZWl7Yp6g6jrUsj1EC0ncvF
 1InCq8phTvRIeq3XqTauhFmpUGuWiZdm+nPc+rC3gaeo+D6cMfaRx89a1nyqtBoMt2c+
 3KdV7d5QFG3bSZtLDXesBk8zyXLKA2hGXOKDXSqkUYEqGsJ1bhXhIpMISMzK5HhnSEHW
 cXVWOUajJb40a9sLaHAXmX+wKsyniZHOWwcOezeIKKmedyETkHIHu0MdAEtPqQm6Xq7x
 /dKQ==
X-Gm-Message-State: AOJu0Yx+ZW8HT2/lqAWiMvQJAvz0qnv+wvd2HVCsVKu6M8cFxyWIAm88
 KQm1jceqgKxwa6x4SkWyZlzOUa87i0MwQViEkSv89HtTJUHh09fzr505dxi9wVJmA40HFfdJkfl
 sWjiq0Q0e0+GhgYRY0PbNFV6THyIRF93l45+fLB1oeg==
X-Gm-Gg: ATEYQzz1xknSCjtow3FNqlo0i4z5lGvTJzS4isMkn7fE6Cs+JTSqS449jmRUCafnURN
 SacWACshoF9fZ4hWlGk98tWmf40p2vlETxOIFe4VfFkOfLpOUaNopf1mgxMulwRbOKb19aahMED
 GzGI5XIQ983vu+tIQnUReH9becIEflsj4QCw+ER3TZc4dm/SbD9AviH6A56XKKW+60pl6HAQ4TF
 7fjdk7bsNhbUhH75WsNPhvmb7JO+XmrS3d++Lue2OBfnYR83v36VONzf/JUQeOHytw/BIR7MaJo
 Kw2Et31QJXH7dLMndJwBrcZ3+zVthkBVrJczr6g4pU3P8Sa6JZc=
X-Received: by 2002:a17:906:4fd2:b0:b8e:dc98:ad20 with SMTP id
 a640c23a62f3a-b942280f915mr38101266b.4.1772737150668; Thu, 05 Mar 2026
 10:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20260226204322.87944-1-abailey@iol.unh.edu>
 <CAJvnSUCBpO5jm64Bs3epkc3rwj8bPhgRQCzPt5g4+YLQagk+JA@mail.gmail.com>
In-Reply-To: <CAJvnSUCBpO5jm64Bs3epkc3rwj8bPhgRQCzPt5g4+YLQagk+JA@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 5 Mar 2026 13:58:59 -0500
X-Gm-Features: AaiRm50yFNN9o2s1oAo7KFgQ8epataKnn3iIS5BKQxo0UZoPYsq_mQABcyt3AFY
Message-ID: <CABJ3N2WC9YT=eQvWBchu4qqZ2QyXNnrnUDZ4o7x-kFqj1GNkvg@mail.gmail.com>
Subject: Re: [PATCH v1] dts: update yaml configs
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000256514064c4b88cb"
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

--000000000000256514064c4b88cb
Content-Type: text/plain; charset="UTF-8"

>
>
> > +#   `remote`:
> > +#       Defaults to false. If it's true, the `dpdk_tree` or `tarball`
> > +#       is located on the SUT node, instead of the execution host.
>
> No need to mention defaults (there is actually no default in this case
> i.e. when if a value is not set x happens. This field must be set so
> there isn't really a "default"). Just say If false, the `dpdk_tree` or
> `tarball` is located on the DTS execution host. If true, the
> `dpdk_tree` or `tarball` is located on the SUT node.
>
>
This is a default argument, DTS can be run with this argument commented out
and it will
be set to false as a default value.

--000000000000256514064c4b88cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
&gt; +#=C2=A0 =C2=A0`remote`:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0Defaults to false. If it&#39;s true, the =
`dpdk_tree` or `tarball`<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0is located on the SUT node, instead of th=
e execution host.<br>
<br>
No need to mention defaults (there is actually no default in this case<br>
i.e. when if a value is not set x happens. This field must be set so<br>
there isn&#39;t really a &quot;default&quot;). Just say If false, the `dpdk=
_tree` or<br>
`tarball` is located on the DTS execution host. If true, the<br>
`dpdk_tree` or `tarball` is located on the SUT node.<br><br></blockquote><d=
iv><br>This is a default argument, DTS can be run with this argument commen=
ted out and it will<br>be set to false as a default value.=C2=A0=C2=A0</div=
></div></div>

--000000000000256514064c4b88cb--
