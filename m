Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2CCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 08:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9A240653;
	Mon, 22 Sep 2025 10:27:12 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 379EA4060A
 for <dev@dpdk.org>; Mon, 22 Sep 2025 10:27:11 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4b79a332631so49710811cf.0
 for <dev@dpdk.org>; Mon, 22 Sep 2025 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758529630; x=1759134430; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgTkcoLmbt01zNX732MAwSBIBKqpwUsBELQToYPwmLQ=;
 b=NYISNdzTyxpHOEDSgwricd21ZaryXVQ3zQfqEp54+HBf0WeGr59BfRqVqHsQlWdzYY
 4u0p0zZWIXgjzV5W6IWm2ErapiGCutPAEPhULYaMOS+uhQ0L9UY1ecrLZitD/cF8w3eO
 +IEbeh6oGksAx/vDOAm9pIC25QU2oKpYTeqkaRVipfOf1l16CexA4is/Yo+gCsai2ZDN
 fScIbKmM7VYrMi6ep4opEC2UdRSS7rQF5M2KatjJymTFSX4lTHkIF3ehBWlw4unqBa0+
 C/0DHE3YiIFWgddp1S5cRdnJL/AQVWVHBN5j2WZ/fdZ7dlcZXgbGEcFjKjO5QcWv91OT
 cY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758529630; x=1759134430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgTkcoLmbt01zNX732MAwSBIBKqpwUsBELQToYPwmLQ=;
 b=A4cbKKvPKxofkCNSOgjyi3LVAn2I/yhTwtVDW4fbmGzKt9GSacwm8RuJavmxrzSlPP
 0ADNSTz5fzcGbTFciVThOTGFIIXFYf5Pcsq+ccfTHnICIHgXET1JhVhXx57zZcTmKRB+
 mlecO52npomgWYf3xYpo0515wq8SjuUw4ewO9KSJsL/yW+Q0PK5nJhe8yhFsY6UXwHAH
 zb5F7HLMs5RuIQzHJ6YHUuZpaqsQLa9mmmlE0+VRx+ygrkleivTptvsCusY3V7ms+yoy
 D4qgZ3CZ3kIQrN7OcH/ZgwTfe2rAitEVPUvDGrdGtAsSfo4carkea7zFIcNyj7CXKnE4
 VOLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlyjPYdjh4Et5sAp8uSuSaFtCp8oJiYLVF6NbdQ25cWi7SzI9hdBmK7MLue0TRiF3WOxk=@dpdk.org
X-Gm-Message-State: AOJu0YzCjPA+azoHi15dtzeV/cJGLt5RYkqZNxC7smz5jmPJ0ydKvg8q
 Yqc5srG7KUyLFZph4I+9QhF8xB9hAMSJGmviwX9Hj8qFYHQPSR93zL1ZsteqNBzjLlg3H3o4nTo
 UeYqsT7CY5nvddvLohRaUs2WXlDUlSxo=
X-Gm-Gg: ASbGnctpcAGpsSpUknVuDU2zSjN6V8BHKyqUycJCW71f+Di12jpQRkS0fzqdOaEnaqr
 xxogsIgQbsEG5XM9p69p8DgUuQRhBJ2Jf/Q9UpVzEHJxwynmWBizD+F9X86tM7EyVNhcIlYSbiF
 K8jH6ad0jxyoz8hBHSeUi/A3VDjz9+gES/kJuwU0BgSmhaEMb02v+iS8EqWiTf9e5z3Fc3UFUw8
 4XBGdaXUTRwlU4nqE0VVHE1RfBnbd8ABspWihdOJm0+4YNI25rEw7of4ZNFKPg=
X-Google-Smtp-Source: AGHT+IHZWoP8l674+h4r35ntYLoTYA1JF/RqckxuFdrDmjC4kMw+bgYoStA3yvYZsLx2EcCOaCPAIyCX5aTinyVOk4c=
X-Received: by 2002:ac8:6906:0:b0:4b7:a92a:fbe9 with SMTP id
 d75a77b69052e-4c074a12ea9mr124804201cf.60.1758529630286; Mon, 22 Sep 2025
 01:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20250901073036.1381560-16-ndabilpuram@marvell.com>
In-Reply-To: <20250901073036.1381560-16-ndabilpuram@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Sep 2025 13:56:52 +0530
X-Gm-Features: AS18NWAfd_VJXD-F1zxGgylGOUVV8xW_FTI18JZukcas4YWHHO3j6_CzE1s1Ewo
Message-ID: <CALBAE1N-EiCet9_fzm3KiafkeT1owWv8cBRVFPYGxcR=HX-kSg@mail.gmail.com>
Subject: Re: [PATCH 16/19] common/cnxk: avoid null SQ access
To: Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, dev@dpdk.org
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

On Mon, Sep 1, 2025 at 1:03=E2=80=AFPM Nithin Dabilpuram
<ndabilpuram@marvell.com> wrote:
>
> From: Satha Rao <skoteshwar@marvell.com>
>
> Condition to check SQ is non NULL before access. Also pktio locks
> are simplied while doing threshold_profile config.
>
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>

# Please start the fix commit with xxx/yyy: fix ...
# Please review the git commit message in this series.

Also fix following issues

Is it candidate for Cc: stable@dpdk.org backport?
        common/cnxk: fix inline device API
        common/cnxk: fix max number of SQB bufs in clean up
        common/cnxk: fix error handling on inline inbound setup
        drivers: fix Klocwork issues

Invalid patch(es) found - checked 19 patches
check-git-log failed

### [PATCH] common/cnxk: add support for per packet SQ count update

Warning in drivers/common/cnxk/roc_nix_queue.c:
Use plt_ symbols instead of rte_ API in cnxk base driver

### [PATCH] common/cnxk: add support for SQ resize

Warning in drivers/common/cnxk/roc_nix_queue.c:
Use plt_ symbols instead of rte_ API in cnxk base driver

### [PATCH] common/cnxk: avoid null SQ access

WARNING:TYPO_SPELLING: 'simplied' may be misspelled - perhaps 'simplified'?
#7:
are simplied while doing threshold_profile config.
    ^^^^^^^^
