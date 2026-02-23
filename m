Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B0BEC1112
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96B934025E;
	Mon, 23 Feb 2026 18:21:08 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 56FC2400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:21:07 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so4164672a34.2
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771867266;
 x=1772472066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkzHqJHpNM8chWReBQZe8QfEdc40rDqvNI0WCZNxa5g=;
 b=ocAP0vlXjfXjyibgwr92ygk8UuutqA3BPfQNqNxxl+IX5+RW3RpnODDdorby7pq96z
 iQm0h3wkCWKczGkvEIF1sHrNTb2RcFyd4wn7Ala5em/MQix66wUGJjE6PFwnNrylmbJT
 D0A7IOA5x18F24yqEoFhXON+Aedl7wABNO06lA9BDdQYzWrS+wwn+IBC07uhJQLOIBxi
 o4Kzx4sA6rgPKps1/7kM3+WX5RT4IXEAO0iZIdDbie3qIzhFss8xk0nKREYnEEfeU/Rt
 G6yepsitykPFKBzxX8WayvGvD0ZbO3IKSJyFEk7j0KK6vG2CvoPdGasn61cYV4Qr5+Yc
 Pfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771867266; x=1772472066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkzHqJHpNM8chWReBQZe8QfEdc40rDqvNI0WCZNxa5g=;
 b=p80mT94RVzGwsfxaz9ecPRSZuDmvGiwC7UkmVtviuIHt0aiIVXB7FZtUXXfaB3HDTx
 3x/n/SYx2LGCl19reqq+5ExW14gGI91XbYjF2ohIhOsk6cL/tcdCXzXx8cwErERZUff8
 kUjJ+mbwvCqrjehrmrcbk7ayrLXQHmuNQRa3d4HeQbVqH0FVYglvgpmBZg/kLS0NO7U6
 s0hb38onz2EbRAtdNmIGRKX+LowSjF0OIYWqzwUCxKOo1iBmKxF8a60Zr2sEOpN4iWmI
 p/m8JjAUMdm+cv3qiNX1dDZQW4lfmXdhzIzHgRqWurbniqrO/Wmd8qR03LoduKixcB4V
 W3rA==
X-Gm-Message-State: AOJu0YxIjU9TqXeFAABJ5RjBAslnVWxhaeNuW6+96jD7j20ZKol3237i
 FBG/pSvvXa3hZuLuP691XNsVjdDA2HVstZvzwJqw0sDvc2V6D863Kj55uDIZEgbXWX0w5Zb5m8m
 KCeIR
X-Gm-Gg: AZuq6aIXxA8jIKzbxGHSqiB86Z/FE02HJ0gJblxTp/NY7Jt0u9k3zKdsioU3p1h3Xdi
 7KRM5tSDRPI+yxMIRfruFxeN+3m35pG4gRUnTnZccr4S3g/5FGys/vTidEGX4DDwaypMTCuM/2i
 lRzm5Y/YU4ep7BU9SOgm+JeAnlSl/aRIm++pnN9eGgzUX3yny8U/PK9aHFLcS35f2vZ/wOyW+FB
 VM6jfxOm+4SrJH3IFp5sR7nATqDJ+nR+FoP7CT3NFYoY7SqSnU1vVKlev7E3N+3hLt5aiB7H5O6
 Uo82w7v9ClDTnYof9vqd9KN8tRFrJRihhj9PCPxfRymFf9Xxn5H6FhxPUvTqs2NwbHavKi7xn0q
 1EggaoalSS3EDY4zqcyYdHEmqfqN3jsnZv5AW42NJ3pho0HAuJ1wbD/a7VXPg8dHgpQ4ANdmbxa
 hnP4gSGlz0nB4q2rSJTBZvBjNci7Jn5EWSqbBC+xGq51a30Zr/UbFWIDm9gx/P1Wzd
X-Received: by 2002:a05:6830:2701:b0:7c7:266:392d with SMTP id
 46e09a7af769-7d52be3de89mr4815124a34.13.1771867266484; 
 Mon, 23 Feb 2026 09:21:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f5b9sm7569261a34.8.2026.02.23.09.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:21:06 -0800 (PST)
Date: Mon, 23 Feb 2026 09:21:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] mempool: introduce statistics reset function
Message-ID: <20260223092102.20446fa4@phoenix.local>
In-Reply-To: <20260223102054.336350-1-mb@smartsharesystems.com>
References: <20260223102054.336350-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 23 Feb 2026 10:20:54 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +	fprintf(f, "    avg objs/bulk put=3D%#Lf, get=3D%#Lf, get_fail=3D%#Lf\n=
",
> +			sum.put_bulk !=3D 0 ? (long double)sum.put_objs / sum.put_bulk : 0,
> +			sum.get_success_bulk !=3D 0 ?
> +			(long double)sum.get_success_objs / sum.get_success_bulk : 0,
> +			sum.get_fail_bulk !=3D 0 ?
> +			(long double)sum.get_fail_objs / sum.get_fail_bulk : 0);
> +	fprintf(f, "    avg common_pool objs/bulk put=3D%#Lf, get=3D%#Lf\n",
> +			sum.put_common_pool_bulk !=3D 0 ?
> +			(long double)sum.put_common_pool_objs / sum.put_common_pool_bulk : 0,
> +			sum.get_common_pool_bulk !=3D 0 ?
> +			(long double)sum.get_common_pool_objs / sum.get_common_pool_bulk : 0);
> +	fprintf(f, "    avg cache miss rate put_objs=3D%s%#Lf, get_objs=3D%s%#L=
f\n",
> +			sum.put_common_pool_objs !=3D 0 ? "1/" : "",
> +			sum.put_common_pool_objs !=3D 0 ?
> +			(long double)sum.put_objs / sum.put_common_pool_objs : 0,
> +			sum.get_common_pool_objs !=3D 0 ? "1/" : "",
> +			sum.get_common_pool_objs !=3D 0 ?
> +			(long double)sum.get_success_objs / sum.get_common_pool_objs : 0);
> +	fprintf(f, "    avg cache miss rate put_bulk=3D%s%#Lf, get_bulk=3D%s%#L=
f\n",
> +			sum.put_common_pool_bulk !=3D 0 ? "1/" : "",
> +			sum.put_common_pool_bulk !=3D 0 ?
> +			(long double)sum.put_bulk / sum.put_common_pool_bulk : 0,
> +			sum.get_common_pool_bulk !=3D 0 ? "1/" : "",
> +			sum.get_common_pool_bulk !=3D 0 ?
> +			(long double)sum.get_success_bulk / sum.get_common_pool_bulk : 0);

This is getting verbose, would look better as function or better yet table =
driven.
