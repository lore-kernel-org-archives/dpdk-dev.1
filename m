Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D7CE9A02D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 18:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEAB940261;
	Tue, 17 Feb 2026 19:21:10 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id C6739400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 19:21:09 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so654497766b.0
 for <dev@dpdk.org>; Tue, 17 Feb 2026 10:21:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771352469; cv=none;
 d=google.com; s=arc-20240605;
 b=I1TT4YYG5X++kKwUtdFa2rAK2VRYEx6PtnFl5Q7lvP+4sC7CtKozE3m5Z026GOFWRA
 HG8Fg/VeP/wjK6TmS/N2QifEZaF5MdIpdKVnbk17M11B5U2VxU40iTscIvaIvH5FHKzZ
 OJsn/Yf8TFQSnjQtQE1bSDoOI/i0DojE/2t8duErWW1WvLj4S4S3+tdSoIvHr/8hGl9Q
 YQMzGZ4XBjVyB8B5jLCoKVrmfA7qV6AMA1KXw2rfyYeAFK523RlXSDa9cuHAglhmqcSd
 UAezPV7BPlu/tNvFMMReoAXtAQo3OdmQHVYmvBT/5yErIxRiGwvNg6fWOWTpoDEUuuTt
 /iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qw61FNXcBQeki1qGGu/mUwxSB2+2/bXbfovpTODOcmM=;
 fh=vgsjHWktS5bHo5VZt5Hg6Nar74/lxuILTTw6TxKyZGw=;
 b=OFol0dMLSADMxvQI9ZlJoWZyixnFXvLxtBfbsz4GftJk1PPss6LIKB2qqWLfrqgktn
 bEghWuglFIfdQ7Ml5re8Ad4JFi+Mwn2CeLpjEiJ+0qVWib3XYLX/iu2VzM+8tIG3K95Y
 HnXk+7OYBPDkQhjn/wee5uKuxeGeK8B9dI5HE9ZtYlgaqnqAfqDcUmtpzB8ZCcOzATnx
 Vs+s3GCaUjKEfCnQWIb/jqF8RaXhDZykh8+RdAHuksrZpngv2o6nXgdl9+bvARwwiPTA
 +W+ZQR2TgKctoR3/LCNBAVeTzge2jUiC78ADIRoHhGYW1CrGqG2dacDCxu1yKEQblxOv
 ekUw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771352469; x=1771957269; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qw61FNXcBQeki1qGGu/mUwxSB2+2/bXbfovpTODOcmM=;
 b=NjcybelGcLNn3kn0ZoGc9LGgGn/56EkDVeiU6hsmy3rBFUDVlUN1DsHD4Jfrl84CD1
 kVc8bpO0P8XE2edjkP9cYlQgkWpUPsu7qQVKjfIhCfBiBKfULJevXHJ9P4dBNAKMHBnT
 cypB33CZvnLCbSkrNuJqC4TMoamOj3mNjdO5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771352469; x=1771957269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qw61FNXcBQeki1qGGu/mUwxSB2+2/bXbfovpTODOcmM=;
 b=ZFwKSPydEr0iMBaiYnGfYohqJXHJ36zljBwb/f3vClJ6BHhphFkp6azrazf1oX+Duq
 o0WXCUXK/vnVVFJ8+XwLCP5/HN5fi+h/E9zCbfoCwzhd2VB005JxVEGdiLCQ9Tb57zQS
 1wCYp0LwhSD7VbjSc28iVW3O36S0Q6/7xqQZENJDKdHBLzIut0P4e8j/w0UV9hreQgXi
 rTiFur9/bytrySeZAiBn30y7koy+DdjIWeX2/2cUbm3a7cCNIlHzTZTQ4507mKn6zmrT
 NfMZ91wawBcjQ7kFmWwh/8cWiQUzuxQGyuTExRxBVDUiihkfkaHN/t/iGydMqnPhO0/h
 S95w==
X-Gm-Message-State: AOJu0YxC2JpFmgRReZKiBrp3C0A61p4B8Q6GjMDSm8pDOzAAaBEwkGig
 O6WCCQrO+0adpf4t7z3EoiPKFD1ML31uxReFr2AL4GCLk2pUEobn+dFE09iavj1L3ZqUvsN8Qbo
 Ptq5n0pWtXoJ1vlIJeLogrv/X5/lhhnp8bnurRV1EFQ==
X-Gm-Gg: AZuq6aJJSE2tLfwa+xtJz2QYlqbutNvfpzj0Tbw0LQuRufTe5JISVEJPuwOg11AvkQ0
 JEZqmCS1efmz46ZcTNgVK9rWtsZotSjJbvqHXj9CkqVnh26BhicmgHI46YILeDtbvpS0TJt5XNl
 8laUFzm4ondbzbCtB1Jt8ig0M71EyoM2CFV40SatziPqBXD4RrznSnAVXjn6dXzFRhAZc1X6ZBJ
 sDzCkXsFezPkZNqjhWdFZHPjlFe1fwaRiZvHUUPQDsrRuZ//9txfVUn/tPSOMTYas+CGGCN1GYv
 paDpkzRhnTRuV5fkYg2glhRJMSdZHS8uOJFhO6KBOICEhljwiKQ=
X-Received: by 2002:a17:907:948f:b0:b8f:b082:e26c with SMTP id
 a640c23a62f3a-b8fc3c46407mr773898566b.40.1771352469287; Tue, 17 Feb 2026
 10:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
 <20260213214107.234072-5-stephen@networkplumber.org>
In-Reply-To: <20260213214107.234072-5-stephen@networkplumber.org>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 17 Feb 2026 13:20:58 -0500
X-Gm-Features: AaiRm51fej04FstrxOpoxKppAXj0KKtpS9yOAod9c2Offcj5s0VyLXFBi5S9sFA
Message-ID: <CABJ3N2Vj61UV-s8JmZBMYLLqbJgwTs+RzWj4Q_EY00A+iVaD=A@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] devtools: add multi-provider AI documentation
 review script
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b445f1064b092212"
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

--000000000000b445f1064b092212
Content-Type: text/plain; charset="UTF-8"

Hi stephen,

The series looks solid overall. However, could you please add type hints to
the methods in your Python scripts?
This aligns with current best practices and significantly improves
readability, making it easier for review and
understanding the code's behavior.

best,
Andrew Bailey

--000000000000b445f1064b092212
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi stephen,<br><br>The series looks solid=
 overall. However, could you please add type hints to the methods in your P=
ython scripts?<br>This aligns with current best practices and significantly=
 improves readability, making it easier for review and <br>understanding th=
e code&#39;s behavior.</div><div dir=3D"ltr"><br></div><div>best,=C2=A0<br>=
Andrew Bailey</div></div>

--000000000000b445f1064b092212--
