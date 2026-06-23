Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05570CDB466
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 00:40:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E182440269;
	Tue, 23 Jun 2026 02:40:13 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51]) by mails.dpdk.org (Postfix) with ESMTP id A4B8F4025E
 for <dev@dpdk.org>; Tue, 23 Jun 2026 02:40:11 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5ad49c55ce1so3991784e87.0
 for <dev@dpdk.org>; Mon, 22 Jun 2026 17:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782175211; cv=none;
 d=google.com; s=arc-20240605;
 b=Ks6MXrtgvCybNvkOydXDN9P/ajnjxXXK7fcrPaNUedm/7GvBUrFXVVDObrX7kvHLTp
 Fk2Cz29ZtBfOKkvL720p7Y3asEbRs6amPXZfEPW2aGYK8IAs+6EQvDwQrxv1nIAa3Pxn
 gBHmptH1OzIkw+gof+Kdxk1pLtbGNROuJrfMWlJWMLK2FeiI5nTbbLVhEHfdLak+7k4F
 sJ/KeJZ0Wf8D2BvMJKtJvHxWZ1yzXpNv8+O/DjtHzwnJgdgGb/qQzyew0Z3QWnut7xCb
 xL2ql/8Eutx5+5DaJIO51CO44EZBZWwvCVlxmTDXDqSjkc6k98fZt/4+w0fsxXkm3Nyy
 w1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2RgJh/GLmYiLbbZEynOmztMv3cFf9WuzqEGX3A2WKRs=;
 fh=3EbqZozNkKdOYTWM7TpxeIQlQ9j8sEcWKopb5f+4tuY=;
 b=NGjyedonnZwdBmv448fN/6bY45Yk9dXed3awVWMW5oPzAmvvg7voLYE+hexsyL1cnJ
 Bh9K9gZBpBA4Mj10TO1vyfIMS7iANL9llpsFlFVkifJPSAEISLf3ldi5Ose8ARpAWInd
 E/yVyZnL776O2fFrUOrv9atHqIkFyE4xcZAf90hsqtGXOJlBlbyLCUKq4PFeODubQMK0
 D6u95dPi1GA9WUd7MdH0oemOAhf1lum0tdIvNiNFcvconYu0VdQyuZGhmGu/Vv0GoVfo
 jiMQu8vVTYV+i8W9k7DRqWHeKfmyErNppegDBLbrI/3MFxXmjiPLxRWFTTRvJsVJIMrG
 2bdg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782175211; x=1782780011; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2RgJh/GLmYiLbbZEynOmztMv3cFf9WuzqEGX3A2WKRs=;
 b=Nl3tNim9fHj1b0UuGRauKtqF4bB9cK1vJnrXhxVD7nqnA4nQNcZd+VbiVyR6drH5Xb
 Bxm+l9DYHhlqDy7+v8Fwa5hxSy/4XkMy8WDpouI3nzWP+cZ2rHkSbjsAJdVGdJ50yrYp
 9oHXrt10UhJKwPPyZS+I8+/6JI5ISHRPWeUQ7U8A+DK/Fqk3dhQUk1XN6sxBp6q9q3pt
 P0gP9FHSKf0twOad30VS1dHkQkwNbhCdIHtsDrOVYa53N37gvKVd17W0H+SJwbmJM25D
 9OsLYFZbRbleQpFRBpW4t76gfIm9zNP06rdZAY5yJYQcKZL5mJDmDoKMwDjw525Jvank
 oxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782175211; x=1782780011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RgJh/GLmYiLbbZEynOmztMv3cFf9WuzqEGX3A2WKRs=;
 b=KHFugc3FF7sVhVB+XTp+g+Vd49N8/0x4GA60bHESMx3h+0B1F7h0Tt85zDDFo9uGHO
 ezRHhuNy54I8SIjwspVjMnLbLNFlre4cU5XLJtRwJQ3351+NzLNF0qTC6YCsxqUdjuzm
 XOHlploSnKyTH1Nbk1IjKOabnSA3Ad6qYAUA7IlDDY/dJvfSw/3nVAFTQRjPmmM1H9tE
 IwXjz9z5unPVUUj6vjApe34yFMxF/tzgRAWOGfqKuNG0bGxzWKnX0Yd7MC+Khi2/1CBg
 8MKwiG7X9R0vgBGl4fD4kEC+Xa483LTXnfhUQEp5fa6/ntT1MeyPFHFaHWVnLE1BIeYo
 J9lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+z1/cAzKpfy/deXxA4BBep7hUjrjrD3zHgdIBYoKE905e2umc0hFT5hf9tkdWpAX+JabM=@dpdk.org
X-Gm-Message-State: AOJu0Yz8T0H1OPWmlUEd3lxleEak/zdRjR4hSMpI5gjleQmBx3J2IK5a
 ob4U3RJAvc+U6ws/j4hG6KvbvA2vIyGI3opcGcACcgQpY5Px0uDLi6M6qFmgzk+zqkDh+sf0pJk
 Qb+YcB16/7qoPSHF8i1ggjQfTwTY2l3Y=
X-Gm-Gg: AfdE7ckW3GdRGtM7De4Sxx6b7QJkDsmxGp/71zTovOY9rtOzdmuEifnksAI/nwyceNK
 8mNuoRfpV3FzbZ0/b+T8vybeezGRwQDvPY2O8RZv653UL1ok0cNFTaujNEB0IKdNttBWhzmJzo5
 doVYH6+shvQT+vVI02BJ6u8fB2KIPqZ0Pd9do0x2xUK0x7QbS7TCaif+VwF6HTJf0Brb1dAe8IF
 WNAGn5DHsjLex+jdU1TEXIGw8V8uxe9YGfDGWe8mI8h+quY6N6E51CjuFrN+tmpTYuXCw0CMUL6
 KRvD1brmMOluDqIR1NG4SVs+reaSHSRlOA6OkTQQwKfU9p6a2nJpJAXL
X-Received: by 2002:ac2:51ca:0:b0:5ad:5af6:2562 with SMTP id
 2adb3069b0e04-5ad5af62796mr3723510e87.34.1782175210686; Mon, 22 Jun 2026
 17:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260507163659.40739-1-abailey@iol.unh.edu>
 <20260513154055.134729-1-abailey@iol.unh.edu>
 <CAK6Duxv=rS07Wn9OOv=97DbvRYVNGmydH7_MPkcvXL+_dQC51w@mail.gmail.com>
 <CABJ3N2XixQhhXEnfWJYU_rOou4zXUiYd2SuAV5WYkAgCDOFn6Q@mail.gmail.com>
In-Reply-To: <CABJ3N2XixQhhXEnfWJYU_rOou4zXUiYd2SuAV5WYkAgCDOFn6Q@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Mon, 22 Jun 2026 20:39:58 -0400
X-Gm-Features: AVVi8Cfnh1SJ9v0pF8FrhYzuJLXiGQrYSB-P083G6_e1Zq3RqKJ23u9VwX96tZs
Message-ID: <CAK6DuxuOvcM9qhr-QUmhJ9oYe4wh8E72TAiYM7KTWS22SXo70g@mail.gmail.com>
Subject: Re: [PATCH v3] dts: clean cryptodev environment after a test run
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, lylavoie@iol.unh.edu, ahassick@iol.unh.edu, 
 knimoji@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005c4bff0654e10092"
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

--0000000000005c4bff0654e10092
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks.

--0000000000005c4bff0654e10092
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks.</div>

--0000000000005c4bff0654e10092--
