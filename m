Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C765E83060
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:34:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1CB7402A2;
	Tue,  3 Feb 2026 09:34:39 +0100 (CET)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id 9CE624028B
 for <dev@dpdk.org>; Tue,  3 Feb 2026 09:34:38 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6581234d208so8899328a12.3
 for <dev@dpdk.org>; Tue, 03 Feb 2026 00:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770107678; cv=none;
 d=google.com; s=arc-20240605;
 b=YO2H/lymFkaj6stoXXuovWYOLQ/1BWRoEOw3+0iG82oVkGWr6f4OXJjfOCpSOwiJXl
 GRmOmnrsQBQxtQ3ZdfgQtWeSTQOaOvWAFicITbS11xDmmHjYp7oIjf2cT8PH2YXsui0K
 sogDy2264bcRVoF0WSCCjC8bqdUxaYRt5TUeLCnVeXv6cnzI5IGKNMrqnabKskZxtYbq
 NUazcgCO65VDxFk4hLUPzeHsuLHvVK6mlKcip7CvK2oVw4sy9MRYPFsM5QWP7S549K/U
 2CPNN6nVCWEPftjgshjKHdNITxYApdBZ2F5ays+R4cLGLH2oiNL3krlEYck7Nd2ayJo+
 wYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8FCgt4sUI0Cg1tUsGS+5bBjrIn5a2yeQ5DgoMk+Cu5o=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=X7LDQ0ThlYQfWatnmH4KUuOH4KIO8zotgQnevZjYDvIhagoAfC3kGCWRPEleZaspiT
 Qccb2/HF7qUxSXTG+Eg5TOlHywHAjFfWauCB6foz7lYDvmVICHy+B9cQdFb9psn6q4IY
 HhsRGDJxt/+01hiSZG9Ee1T5ivVWA8oUrYUuEtpKvf059/iKdx99JdwlxhkwsUGW5ONo
 T6egiHS4HJxIZPYDZ5frlI7s7eDEYNhYAFHvkhw5pBSetogWZaVjCm/OD0oXTdsN2y6u
 poQCM0rmDk8sgaEjHgk5E8Qa94/JncJuL0/HGn5+ccG24+bJqcrEj3Rtp6iWsnupL/gv
 60GQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1770107678; x=1770712478; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8FCgt4sUI0Cg1tUsGS+5bBjrIn5a2yeQ5DgoMk+Cu5o=;
 b=dBy4rS3rrutbGQrixq+yjK2SjDaQwrOx7GTl9VKoTbqJnYujkj9McLf6Fd6rIYIDNC
 VlZIThG1C8xSFs70GJ8RkR5CVsjjwtQyOFzHAyfKdZnT8BepMPGy5LXCtGxjso7t0UIC
 eMoxCPxeTggKl+8dQXnhPDxrjkyfHfct+LThs3J15h/Uenyo3wtkDCDSBg2689Wvxfqu
 A3wlmj3GkdQnXMEIMVQdx0aDbvSv/DB6rJilODxCtCQ8mUNSa1jA0eY1yzbggE+7kVn9
 gbpKX/C8VnSSNr5Vsxb4+ivhieT2jxCInksYAruEp3BkCPhjVmYgHqRoLM468patoc1P
 JViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770107678; x=1770712478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FCgt4sUI0Cg1tUsGS+5bBjrIn5a2yeQ5DgoMk+Cu5o=;
 b=YsYgc1wyCo1mPIIZ8BKlo7lJ9vXE5eeEOVID0bMjpckjWAu3r9V3CJl9I29E920F37
 aTg3lKoWUkPVdNi+O110P65Detqn57ibXOR7moANhiMqhAtSCo2RJoP7g1uDY62mmY1d
 DddwcaLyrijz3TwLPgdeEhM9Z5bPusfMJaO1sj1kxQSDeOeGA8vdAAQ5gU9sTXJAETIx
 V3ao5RVFvN7Lgse23QDAQlj3sIuzumVF4lCi4dDCd2r2h9sPVKL30vV4tnTFF9DxvQo5
 o8gTvLq7+96zSjfw2JlykXqyddyHQgNcsb0Gio1FNztC9x+s8Bo3EIcRuE9Zj96lJVCb
 /eKA==
X-Gm-Message-State: AOJu0Yy3i/Oh5D1RPA3FNE+CMRCihyzgRuvS5Lc8is8Wd9izyO/jq2+l
 X0Ahv8gYAy+jX1hFaGKSeji12AWpt7XrBZHCqkEfYEt7oox5OfdvzUtqfQIQZ9pjKOe9GFfU+uo
 qOM9Qvb3MbO9exHE4AQKSU42OpH4WtRtqeqvSm2SaYs5Hq+UPcWyc
X-Gm-Gg: AZuq6aLL9xS+pPrA7Mw4qaVbBLpPg++4w67JPNUkRw2iqBgikWvCaIvJ6bknQ3rIBLL
 Q2jzGwt8bR3ceajMqTDOCgYgBSL7V6GBHN4XXGPmmv5Ob0XBinOecxcUGw9Y9NowtbF2CPkLGL+
 PiebMchY0zdWVrUe4MgHRdHuzYow6LY3u+3vJUQZLmTDiykPNk4xpTz78LRdqbaLzk5/47OVtLX
 otPTJuLbEJpH00C1LRwk3tL0DkoYmWT7R7AO8YZJaxehFyaZX/P598xEpT8V7921m3HWgsf1Yp+
 tKA=
X-Received: by 2002:a05:6402:5256:b0:658:1421:b569 with SMTP id
 4fb4d7f45d1cf-658de58528bmr8107794a12.14.1770107678111; Tue, 03 Feb 2026
 00:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <20260202113659.24052-4-sismis@dyna-nic.com>
 <20260202120313.15ecedb3@phoenix.local>
In-Reply-To: <20260202120313.15ecedb3@phoenix.local>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Tue, 3 Feb 2026 09:34:26 +0100
X-Gm-Features: AZwV_QhBInG_vx6OM-yAmcMIFZBZpy0kDXk2saehwcNFuVy5ZJuFkJUG7rwpDRU
Message-ID: <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005e4ff40649e74fcf"
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

--0000000000005e4ff40649e74fcf
Content-Type: text/plain; charset="UTF-8"

>
> The kernel version of checkpatch complains here. The DPDK shell script
> seems to be set to ignore this but.
>
> WARNING: break is not useful after a return
> #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> +               return cmd_flow_parsed(out);
> +               break;
>
> Should I create a new patch set or just let it be at this moment?
Lukas

--0000000000005e4ff40649e74fcf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">The kernel version of checkpatch c=
omplains here. The DPDK shell script<br>
seems to be set to ignore this but. <br>
<br>
WARNING: break is not useful after a return<br>
#15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return cmd_flow_par=
sed(out);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br></blockquote><div>Should I create a new patch set or just let it be at =
this moment?</div><div>Lukas=C2=A0</div></div></div>

--0000000000005e4ff40649e74fcf--
