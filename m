Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7AF54AD9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8533C40A89;
	Tue, 24 Mar 2026 17:50:45 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id BBAA2402BE
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:50:44 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-89cab686a9bso11866666d6.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774371044; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKu8bfPQlKMdULLsKSVkQR16hFYi9Vq6B1/68fBdvZTKiUQBpXBT+LazeJmFRY1y1d
 LjvaBqMsi8XywIIS0ycRo6gImmYKjO4mZsOEHx0rKPEIM4YbNTT+oa5PH3dIA/jl+VEk
 UQV/+1t3VnfvvVs4sG2QptgjCa8RX2KVhyx4olV1fJqAqzn3aXPZj64rGtkvR6B27Gpf
 ct5pO5iizuI+Br/nkaDuUBDf5uWvdi9Ta/6pfbNuGyXI1qHFz5MZsM6qgN8SPhlkFEE8
 zpBOvbx57a+anxMJ5TuOccJEK4inbWFn9m/d2O2UGbk/6WwmD0zjnn7uakSZQpYMg7lL
 lquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4hxJqcY+K4GmFfP3187u7UNTYYqoWXXqlPAxYhqb7Ig=;
 fh=tEitL3R1a0JDscaB564gL0nwN4f9R+yqgYRo7APOVSg=;
 b=E8WLsP1zrbmJ2rfv4+5g0acaxDOuYexH9n7l1L8qesch+6vinrDEpojbtx5fq5VqsQ
 DoNVoj5Osx4+v9imATUka0X55Im0BAdd75iDqA//2gG3AuQoViW38RsihJaEHvhoS4e+
 d+cmv/I5aHdwNpFrufjV79Jqy+yEJyuEGHO7Lm0vO5GW6dNhW7rh8dhdfytuv0Ty1Hff
 9jclcER6w4SLdtkE3q0EwWsr7BiUjSKl+TQj5ow5HqKUNygHP/2BCToW5jLE5qBwxk0g
 FbvUbwQyQ8iJVrV2GdN6QkY4cpGu0X8WGClN8VwwKZjO+KQo0yefUgTKdAtn3CKpHL33
 IQ7A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774371044; x=1774975844; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hxJqcY+K4GmFfP3187u7UNTYYqoWXXqlPAxYhqb7Ig=;
 b=QdA40HooYOnU1mKGVYp/CN+LcoDDShRtzA/0OAvFv+VrJw5fH5VoPk4cNoLRwG+c7M
 f7ZRx8ehYpJaSjs72do3qjJrGtyZmrTAo8bzRyhErepLaxefdb66qbR/lmcrQn1Yz9cZ
 OkyUbTlYfiazByIBE/xUCbXPJTMlZXH8P3H4LlarkpWPJFxmTO6thTgmM590l3XwWxQt
 oAbk5q3x7ReXp/95UDlZif1Bhlsu7q88sOV/OjetTTcX/IVEATPkpcLffw5aVJtXitQv
 +ueK87KKIKC6VvJNqUb4+U0ie6olQoKQa65Ksjlqc2Tt2VV6dCol/SqeW/gjzzn4k5HJ
 iw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774371044; x=1774975844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hxJqcY+K4GmFfP3187u7UNTYYqoWXXqlPAxYhqb7Ig=;
 b=juW5OHYjUyr5cptjl3Kya9Hu0gYZVYEYPvDfjdmhN7WXhrLvEv75F1Utzqpjqh0RCj
 tA1mRG32uKaielN8mviBzgTpyCvlDFJDJ1OVx9Mg6MwK3p0CmJtPjqnzMGPGnxC70zpQ
 eshFd8uoT+reEcxH1W73iXH+zZcQq8OQF1wS4UYNPLkI/uObmeCkMdtKUpJgdW/S9TeD
 BlYIkRZFso6oBxhCVg81qyiZcR5QZ9AFas/jf6BHc4eMdVqoCUc3gmcozizsUwpkJiZN
 UpEvi7IiKd7q8qAqfosXTmWJnOnkkvuV5fXa2snX77tl3hFkeuRDH5J6XUBqoODjQlGR
 O16g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf62LpBrVXWilgucOQTGBSe1s9vZpmWgRhECZRZ8OhSbFknQNhtangtrGJQu9WOxLzVKg=@dpdk.org
X-Gm-Message-State: AOJu0Yzl5tLwYnjv2bb6fXCh82ffGK7FI5kc3GB94MJYR2U8RPHwND4Q
 VTYpyrVoMzbLKi11gyn2Xg4066gH6nWhmVIfJVE/WnvB8lgtBjnyhTNuS31yegWwj9RKCDMorCi
 Vd8GtLEmoFlxEe5EVsc03yoi2e9Tez+6ZgHaK
X-Gm-Gg: ATEYQzxLhXfk+B4KIoJvsOc2/QwtkVtWFyCgFwv9cI+Yu2b5tHdrajdxFW6i4RvlAod
 xVo1RdGmyZGhB5nJOErGIi8B0DggtSUICUVIOIhVd+1ckaBkA3dlGK8rf+tPk5wdMuP2af3PQfY
 LRD0rJYn6+yuYQCatQR3ZhA6Ob9v4roK+Qkz+1+tA5oFaRxqC7yqcGL41CAgz6K2NzRS5xaE3lt
 nvvo53P3gHlxzYt4FaMH//2UqUloPJqHUkc8BHh8ZcjzzcXH8e8xdamMxfKMlXyRIJLQKubtBZf
 8BYWD/qbNJmsOQ==
X-Received: by 2002:ad4:5489:0:b0:89a:1536:251f with SMTP id
 6a1803df08f44-89cc49c5624mr4499196d6.28.1774371043905; Tue, 24 Mar 2026
 09:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260319092723.4153401-1-ktejasree@marvell.com>
 <20260319094434.4154156-1-ktejasree@marvell.com>
In-Reply-To: <20260319094434.4154156-1-ktejasree@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 24 Mar 2026 22:20:16 +0530
X-Gm-Features: AaiRm52LW1G89k-LO677dSuOG9STqdenC9qcY6sQtKE_c6G8zL0PIIvSPg1Dhcc
Message-ID: <CALBAE1MJhm=L9M9mr8uiM4Tj0MoV6on5T+6sUnKDRW3oKC9nmQ@mail.gmail.com>
Subject: Re: [PATCH v3] common/cnxk: validate cipher key length
To: Tejasree Kondoj <ktejasree@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, 
 Anoob Joseph <anoobj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 dev@dpdk.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Mar 19, 2026 at 3:20=E2=80=AFPM Tejasree Kondoj <ktejasree@marvell.=
com> wrote:
>
> Validate DES/3DES and AES key lengths before copying
> into SA cipher_key[] to avoid out-of-bounds write
> into adjacent IV/salt fields.
>
> Fixes: 24d10645bdfb ("common/cnxk: support CN20K IPsec session")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>

Updated the git commit as follows and applied to
dpdk-next-net-mrvl/for-main. Thanks

    common/cnxk: fix cipher key length validation

    Validate DES/3DES and AES key lengths before copying
    into SA cipher_key[] to avoid out-of-bounds write
    into adjacent IV/salt fields.

    Fixes: 24d10645bdfb ("common/cnxk: support CN20K IPsec session")
    Cc: stable@dpdk.org

    Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
