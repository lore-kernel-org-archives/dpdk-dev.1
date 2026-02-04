Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5346DE9D403
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F070402F2;
	Wed,  4 Feb 2026 16:44:21 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 8571B402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 16:44:20 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so9518994a12.2
 for <dev@dpdk.org>; Wed, 04 Feb 2026 07:44:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770219860; cv=none;
 d=google.com; s=arc-20240605;
 b=hWkwusv+FJWgn3uMEieGacw1kPexh7fAeZO5+w2Hy7FGJtI1YnCcJ8t4aRQecC1cGP
 y/rUHf4wuyQnRuVHXgYa6+VzD18Mz80cyZhXLGThFuiQjD7QLb3Oflb3uLwzRiqepj6j
 ilKRC6oP9kAdozziuRp3EufD2Ix/GDiNTJ+0FWzkBIRoA1u1jTAXUH6heITWIXx/96NO
 /5/nuBYfpU7YIfyHmf8zoy2IyHaZoqIHAEPvLr2XQcZAlufxoLc3tluoDtZ0bklj1QFi
 V/bUthQUbR1AVhUBqbcrSCWPNcwzjACiJwe6SVDi4hZtoZiIwyYsvPsurPHfv9YoS/PW
 lnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WPp3i92a/nGy4qJxvTrs0AQz1zj3lW25s9HlOlvuBX0=;
 fh=DYhYx2yxkl0P1NhrfP9R98X/0XUwtnn0poxyvVxw47M=;
 b=RO82v2MEZ1FdjqZLQCIToa761ZuTyPx3xOb0XgYD+ed49OXqRRYHA9eDq3qGZo2oSA
 04urgyMkJkZG8zMrykBV93pYygHZ7dDQ1LGk45xezYjUMjruT5Rjb9IGwto+zDvD1ahH
 4voMyv6JelpYEArKCRUOF9XDWA5SqphEk84K6ot7/VmKu/GvPr5aVxvGA4pT2R2/v0QF
 ydqo5scuiWKqSfIrph4KES08f31KD6UsCrvjYiXgrdeVJxdgiY/CVS2esMzKaYvgiS/k
 ww5cnB+3nbTGtiA6U2jkY90ir9mpyRg8y5TvOG3TgUd0B3Gp/QBNzRu3xi75EBfaxp6W
 oNFA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770219860; x=1770824660; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WPp3i92a/nGy4qJxvTrs0AQz1zj3lW25s9HlOlvuBX0=;
 b=DhVYJclfdToxUMhJzVv01Y+cKNgOJ4z4q7jZEpEzwztHmFfQv6e/EhGxGVuhX/1by6
 VhA5jdBuLlnrMVlAPHfwO6037xK3HU8iLz3Sy6/dguEnomcwyfSJri+dzfS/U/6axCGb
 bibRQHUIjnmPSuWWm3vJpy8pnxnWOrmnxtdA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770219860; x=1770824660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPp3i92a/nGy4qJxvTrs0AQz1zj3lW25s9HlOlvuBX0=;
 b=qWv9F4PetXMy88GV4RAc99BsKWrOHamuCEFwP/q4v/xvJtfLlOXNzJkTkWH0dBD5M/
 3MCkGHahdRvu6orK7wTU9Fh7XlNVhQcQvvtq+3J5Cp1msH+FuKymjuOF0YemnFB3Qd5k
 McOI9L8PAQ0itPGwgHKI32WgsssLoT/GRgNIGcb7THVBdkX3xGx4d4tAvT1Cka1THLUe
 ASejkmDrZa0H7eFkbpBxiGj9GFej/DnzfksDnmo6MbakBqGfxU7v5CUNUcYaN9XVZlVQ
 T26a1eEyC7UxrYwmON7h3PhCg0ef+t2KSGkUcDedYbOATdRqwOYQARhBf5cM26L9WvOP
 XNgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgO+55N4LIUzo9ua4w6iDOGWpeE4n/GilPpUNZyB+sdeSESLqdjwaPiYBSqCRvQTZQ6XI=@dpdk.org
X-Gm-Message-State: AOJu0YwR3NqQqrq5JlzSPbfJB1HwNiwPh1W5lxM8E3kDhJQ2R5ytZOKF
 JWm7sd6TJiuhQzrvFUfx4CNwUBAVE5aogfpaTJptgiZXbbDIJXS3iEHJ+u33TLY1i1UL18peHKa
 0tqtcbDErBS9HeFO+2BMJT2CzSyhVY3oA4HdajKBAMQ==
X-Gm-Gg: AZuq6aKe4dis41KiEFWpOPAuwohdHVlvbqV7Qs/6ByLugWu+NJut/kAcyoXvFpgw6e2
 /iH59kj4+vYjf0hP10S9eYZT+lfQwpTBj867NrQMIIGIZld3LKK5CsgCd0PhzNE4+pN0bhZ5lFQ
 ohrMHq0hCiyKImohZqzNE3JPEa+FuaF9z9dgaTTWOXQEEJ2t2YA1c7FKJOD/mOXUaTnXUZIrIIg
 7s2aQ44M8RpuiQU0Bdav8kdBETjHqZ8mlyF5v4ODmicae0fi5RyirIrVqZHyy4407mLme0M+kTq
 AWQ0UsBgUbVyLxHcPZJVRA0V4khI5A==
X-Received: by 2002:a05:6402:5256:b0:64b:588b:4375 with SMTP id
 4fb4d7f45d1cf-65949bbb990mr2059797a12.2.1770219859988; Wed, 04 Feb 2026
 07:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
 <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
 <CABJ3N2W6QXQ1Aae4QWaZhSMrwMfmDa6oYjHby1YDQJdK2FknvA@mail.gmail.com>
 <CABJ3N2VTZc-73hP=0KG8EPbdrCexYZXToLzhJPAhkN+Eo77DWg@mail.gmail.com>
 <CO6PR18MB4484327639EC118ACFFF3810D881A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2Vf=guy5qJmmbTHY76Bnnn-5PTEkmB+FewahHqDzxJLiw@mail.gmail.com>
 <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2UzbranA3ZTjm42Vf2UU8ajYh8uNVvttzm_D7z+oqH5uQ@mail.gmail.com>
 <CABJ3N2VbQD=jWqg-UBbe2kuWAJtKsxkXNFy_bK+4imvTLR0+jA@mail.gmail.com>
 <SJ0PR18MB449450BE407BA837E2398294D898A@SJ0PR18MB4494.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB449450BE407BA837E2398294D898A@SJ0PR18MB4494.namprd18.prod.outlook.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Wed, 4 Feb 2026 10:44:08 -0500
X-Gm-Features: AZwV_QgwGDTAm6Dz-zQQnG-2jZpgL9dmbK7xfIyDEdiyGYVUiF3fuI9kxaZaDYI
Message-ID: <CABJ3N2XoWqoHYb4byK3YPkNErMSD9=EiLzZhiCVyc73RXB4diA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Akhil Goyal <gakhil@marvell.com>
Cc: Kai Ji <kai.ji@intel.com>, Patrick Robb <probb@iol.unh.edu>, 
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "luca.vizzarro@arm.com" <luca.vizzarro@arm.com>, 
 "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000edef43064a016d11"
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

--000000000000edef43064a016d11
Content-Type: text/plain; charset="UTF-8"

Thank you Akhil,
This feedback is greatly appreciated.

--000000000000edef43064a016d11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank you Akhil,=C2=A0<div><div>This feed=
back is greatly appreciated.</div></div></div></div>

--000000000000edef43064a016d11--
