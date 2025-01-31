Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0300C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 18:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B9240274;
	Fri, 31 Jan 2025 19:36:58 +0100 (CET)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46]) by mails.dpdk.org (Postfix) with ESMTP id 19C6C40274
 for <dev@dpdk.org>; Fri, 31 Jan 2025 19:36:57 +0100 (CET)
Received: by mail-io1-f46.google.com with SMTP id
 ca18e2360f4ac-8521df70be6so183724339f.1
 for <dev@dpdk.org>; Fri, 31 Jan 2025 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738348616; x=1738953416; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mqJGA5jeAevNV1NAplZRrgFHvGUMzgTZASw+nvilV/0=;
 b=W1f8mtW8Wxou4Dme1gABS0CJKlaJlNLAuZzCLZoPeVzAVGWJuKBARlSmyn7+kLWjzB
 ftLFSOKgcRdTSI5oBfMelh0ZhuP7Ix0smKdMpx7DzAnugOa2uQjSfUYv37m8nVd+gFKV
 jblgQsdfkODfU/iqhE6IQKPgu6LadLA5BbXHzAMwTo6mQZPwcH++fkO33Odbkl0FEO5q
 SBQB5owHlHZX9TjKlPAhTi3nhaMIGELBE2vvR1u7mGOE0fw+vuXt4DnZnGw3UVNudBuY
 W7gVeSymsLHJi86SvWo50+4T33XaqXUqBd4YZpwD5s8D8GK0ftTlNiT/k9eYYhD0mioY
 5kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348616; x=1738953416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqJGA5jeAevNV1NAplZRrgFHvGUMzgTZASw+nvilV/0=;
 b=rQGD9tMWGiy5sxGyORm8usEKK/uKKDdvxWxPiZvLUM+y8k/2T5b9ubpwTArWGOw5Kd
 lIxMJmvQQPFv/Zt1UimpaMA0ACNawZ6f4FIB8fdEIcsdw/MKDeZbnYlZAVmNUHGGQopl
 C+Bjac1P/vw4SgiT/tYjCka3dfTcSA7nMGEBYkBvzT8jVZK7dbKz4WCt3RDaHKSDkzjG
 eluiezUEad6rnhMb+06LeringdkqKyJQ4vVdAXSojgAv2gx5B/cqmI2KNJsrR5hb8LpE
 oAqUr8FZdY11xgATKW4sMKrTGgey08N9DhlFwgVlItRDkUzVq+h7UbbUygz3mGo3ezej
 CkkA==
X-Gm-Message-State: AOJu0YwkNJDF1Q7EgNquY5hKHkwQ4fiAlKNvz8s30/ZkATfeu7bRW5jl
 w7brqQu/cSynWDgelL/Ycm/ywVyVciJnX5lGxbj5mpFkqncSvORoOSJBCm7wnTSSXZAG1FKJTkq
 AMOWaAwY6VdrsE1JmZeDBRrlIAHM9d1J9YFt/IQ==
X-Gm-Gg: ASbGncunjuz868X0A9htW6zgPRuUWG1lx1RDafFuKtsuj4c2d1CI5HpLRMtAzLWh95l
 f1fGnm5IsvufGfcmGQ0K+y+JTiYst3X9y0wivSuzEdMWZ9o+tGSzqJEKSKhRbU9IruGu8S9xzkh
 vxq63G2HUepx+DRUEkNwxsFUaxA+Wp
X-Google-Smtp-Source: AGHT+IGnVl91VH11A3Wg1oPVU7jP9KVrOpWWGDbJTM/XhegRA1yiAUcConZjzwOmiSuNZfQZzfU/18DwwR99/dpIN90=
X-Received: by 2002:a05:6e02:1d02:b0:3cf:b365:dcf8 with SMTP id
 e9e14a558f8ab-3cffe45bdddmr116660455ab.21.1738348616203; Fri, 31 Jan 2025
 10:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250130221853.789366-1-ariel.otilibili@6wind.com>
 <20250130221853.789366-3-ariel.otilibili@6wind.com>
 <20250130155503.733797ca@hermes.local>
In-Reply-To: <20250130155503.733797ca@hermes.local>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Fri, 31 Jan 2025 19:36:45 +0100
X-Gm-Features: AWEUYZnpVXB2QcRnTN6n1tFfXfm_cvZwIrX2vw5Ws11uYMYo31me65O58RnaOJg
Message-ID: <CAF1zDgbcZKQREmrr6_pcMQ1fCRWmCVoNPFcTN7GCa_7LUPk=hg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c3e69f062d04d333"
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

--000000000000c3e69f062d04d333
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:55=E2=80=AFAM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> Need space after xdp_desc to follow style used elsewhere in DPDK.
>

There you are, Stephen:
https://inbox.dpdk.org/dev/20250131183439.909831-3-ariel.otilibili@6wind.co=
m/

--000000000000c3e69f062d04d333
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31,=
 2025 at 12:55=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mailto:stephen@n=
etworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
Need space after xdp_desc to follow style used elsewhere in DPDK.<br></bloc=
kquote><div><br></div><div>There you are, Stephen:=C2=A0<a href=3D"https://=
inbox.dpdk.org/dev/20250131183439.909831-3-ariel.otilibili@6wind.com/">http=
s://inbox.dpdk.org/dev/20250131183439.909831-3-ariel.otilibili@6wind.com/</=
a> </div></div></div>

--000000000000c3e69f062d04d333--
