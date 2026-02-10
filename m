Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B219BEA3F0D
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 05:56:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE3B40678;
	Tue, 10 Feb 2026 06:56:47 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 8717C4065A
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:56:46 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-65a196a735eso74591a12.2
 for <dev@dpdk.org>; Mon, 09 Feb 2026 21:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770703006; cv=none;
 d=google.com; s=arc-20240605;
 b=Zkb7iOOcNuC0piHkuMrwHqOsjXgXwBaw68G/e6mBwnubno/ccIS+Nqjjn13jB1tcC4
 QJgkg//g8WJQUBR9yNXIElbxeM2cdwDEIT8oWebsXB8XKQ/6w79tsrPxCZfPu051bLNI
 x7JonWhYV34TpFswsPgz/OHKsT7IJ1q+E8VQZjzgLUxW+iL3t/uReEmUyjwGTSZWdihD
 o9Q/1JwOn71DnReNkleZqcdQ/s5FuxAFRCYAS6+cFfOq7KBuZPQRbWMJHPtXKYCF4dAs
 yVgXtCYcNNCJ/Dho6n+ABLgMUALbqS1Ca/C0NT5OJv+Qy5rNFnu8W732xAhBU0JONbPH
 0kdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=9hvR2rt/g26DSEmkO+YM4mOHkl5m0YIIzwuoPWl7ahY=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=Bm8ZW7y3HE++qEJq/2QtM7Rt+UYDYxo9fpaFNEZAbprp/yl9QyvwCYuSqwvEP1f/z3
 f8nVsYt66vDDHzp2zT4HTtg5q65YjbftQRv+l8kVdCtf/F5UxrtwWuE/oZK/uIukk0ZE
 xLWxRqEexawWbcBZctYNKT83Tzb4JaSAYoc6dOw4BEfAMbHO0yKO+HgLCqxc1gmFArSb
 YWrzbiyoNapCFTRrT+xYofBJXsvqZG2uSx0fJEcKE4NZsQRmh0iEEBewSy7xu94rXd3M
 pNIXEBWbsrnyzgzkvbZata698Qpb9u/Nbpv1ZpPa3a3me7ed6pUBKWGm/ogkRq2Q7AJb
 SsMQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770703006; x=1771307806; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9hvR2rt/g26DSEmkO+YM4mOHkl5m0YIIzwuoPWl7ahY=;
 b=mv8yHSHSowkyrAyIfpb0i0mq8imXHX+IkOu3Qxtp6KCxzKk8DeZHOiR3mha7tp0ke6
 wt2GL2dTDoiO5Bhxrq7IUVzCZjIEvl2xRGcvZFA6VhembmgOUfAOFTBDbp4QkGNot1UA
 7tdl28pwvrXgu4islrmNjA5N5r09ifRK9iqI65VQa1iLytU6zkPSsiZCBZsVOrO17Iq8
 3GM0mk8F6Z5H5Rrw7+t9j0YLAq3VNKNiSmIlo3fbs7oOWIL10o+GG/CFLXQacjv91RP7
 auHE8L5dis+dV65eUZGLJN9fWIzzm+LKYY4OPrt6zZJ5CRxnylGUn86Mo1iFT6DsTAHE
 pVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770703006; x=1771307806;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hvR2rt/g26DSEmkO+YM4mOHkl5m0YIIzwuoPWl7ahY=;
 b=X1F16FB1vcrNPclArR+grEWRLfmXpCXTuoNGt0kB1P9OCeAx+4N7IkPEX7ZQ2hsWlO
 44JU8vlhAe/fy+Ve+z36H7NzNNl/abmkBl+FhVlI9tiGBE/5J50JsNU5rAlqaZjpGd2F
 MBUJrIm351F4UfNpiO5iU2pCibwmeF69A+NfwSCLcck41ypjmmruQ75oH6XHFgraiJhb
 xgpmd2i3mdfNJxuom173KH+DT8OoS6AZb+6uAk8XGros2av43pqEHDVJo3O7yvMyP2iO
 /1bhMD2qv6kkBWSuwHYsi/d0EH6OsNOfB5JaI9gaZdD5ypMhXPxG0LkvYMTfwpaIYqDF
 qqXw==
X-Gm-Message-State: AOJu0YwIbLDlEIq5si8rJ89l69soh4hKs/zrr40cc9G6ElB4Ef1A+DaB
 csIaEx41dlilaZhw2/3aLTOTHH/+Y7IU12V4KRy/c6qlUK98VcfgkxbZal8voeqy8ympGoQ5ZqY
 OuW13nSsDYnSWnK7JUYC06hlWGeHZ7EbfsHRk9S7TkNOp
X-Gm-Gg: AZuq6aIE9Q65YvEvIlmM8cNvotEOAQZ3Be/Q7PuO1CcN+pdoIxHail3PrMKS7xd1nBA
 ASo8kn3blSeb5/Snu0wEuZFDyP3Z2th8Owqie7zwZqnh051pIOrgYle26szTmsuIx4CRI9kQalA
 l3J9BfKlEN9uAKhlZi2BmVtmlOfFZBm69w2OXUUIik9+D8DjLt5CjKsrwNdJec+EH9vco0BMHth
 PXRxo/Pl0CSnPk4zYHkWPlPePqyxcUIftgdoT/4fqmpwOCkxpovjBlGRxeGBg/lM+fBNarVbKsY
 pm/TG+At4g==
X-Received: by 2002:a17:906:f58d:b0:b87:1ffc:bf9b with SMTP id
 a640c23a62f3a-b8edf173b0amr828430466b.3.1770703005655; Mon, 09 Feb 2026
 21:56:45 -0800 (PST)
MIME-Version: 1.0
From: Zhanibek Bakin <zhanibek.bakin@gmail.com>
Date: Tue, 10 Feb 2026 10:56:09 +0500
X-Gm-Features: AZwV_Qh336dp-i2cewriLI0zudbY2I4tGM382t-6AQcmCtSgp8bUETqKanPJH4Q
Message-ID: <CACRNuqcKD6QucokYg=O+WoGXGnMwTEkYWyjyeoxKDoT6_BB1RA@mail.gmail.com>
Subject: [ethdev]: question about the experimental functions
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a7bb6d064a71eb67"
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

--000000000000a7bb6d064a71eb67
Content-Type: text/plain; charset="UTF-8"

Hi there,

I have a question about the experimental
functions: rte_eth_dev_get_module_eeprom() &
rte_eth_dev_get_module_info().

From what I can see, they have been marked experimental for quite some
time(7+ years).
On top of that, I don't see they are going to become "stable" in the next
DPDK 26 version.

Can I know the reason for this? As I would love to use them, however, it
would be a shame if they change any time soon.

Thank you for your help.

Best regards,
Zhanibek Bakin

--000000000000a7bb6d064a71eb67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi there,</div><div><br></div><div>I have a question =
about the experimental functions:=C2=A0rte_eth_dev_get_module_eeprom() &amp=
;<br>rte_eth_dev_get_module_info().</div><div><br></div><div>From what I ca=
n see, they have been marked experimental for quite some time(7+ years).</d=
iv><div>On top of that, I don&#39;t see they=C2=A0are going to become &quot=
;stable&quot; in the next DPDK 26 version.</div><div><br></div><div>Can I k=
now the reason=C2=A0for this? As I would love to use them, however, it woul=
d be a shame if they change any time soon.</div><div><br></div><div>Thank y=
ou for=C2=A0your help.</div><div><br></div><div>Best regards,</div><div>Zha=
nibek Bakin</div><div><br></div></div>

--000000000000a7bb6d064a71eb67--
