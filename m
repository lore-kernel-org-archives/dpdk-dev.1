Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB3B1098797
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1259F402BB;
	Fri, 20 Mar 2026 16:37:03 +0100 (CET)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) by mails.dpdk.org (Postfix) with ESMTP id 6DF84402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 16:37:01 +0100 (CET)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-64e8c7f5082so1881581d50.0
 for <dev@dpdk.org>; Fri, 20 Mar 2026 08:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774021021; cv=none;
 d=google.com; s=arc-20240605;
 b=fjQ26bV4kIttuMZQHb9QuLL0uFMvcTYe4yOmPVEZ4s8joordxQor8fzrLvwJGDqCgZ
 j1qImD2EJMHrSxMtgFMeNIWq2iYw6siqm+6VUWMHpprbUS/RAdPnR9hBEtBvobSVeF/+
 sAuVPXV/l0tE+yGtcQC9Ki6is51JmhKjN5G7qud1qL7HxuYpOYZ/H3NjqkruvUnRk1Vd
 N3PTVKi0K9BDOqUAwfQHS3+0oEknmnBFKHq0w9Yd0Se+hiiDlhM4pP7ttzm3GisJzTkb
 9U4AXpjJQgreqCvne4sY97J7uZ3s8BnGOEGZVCLyhD9l3fAKNFwwfifFW5Ql1u80GWuN
 qFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SP1tkMmpAb4xcYlyw0o8SQilnRArOuWj5BE9yWJumPg=;
 fh=donhvY4VqF2ViBgATKWhSGaEprlT21sibOAfCghDYm4=;
 b=eUG8AEBqdQqzEE/HiDvb06B2WlHtXS01sqkjVt1fDaKYJ6zlEx2Q2di7mwiMH9DxH7
 Z8ZsNK/nIBRm1EgaHoY3aR8t8x2LgjOWay6+Wjfs6iPASD9b41NBdv/mx4nQX/RblLjc
 yn/jP7HSRZ/NJB0GlDgCP6pek0Wr339+mar9RAQfXmBeUL3GzjjgNPp0UYfe2je/U5fE
 ElrHIM4K69Fe4gk3hAHDYPitgCTO1LA/wFvZeN6lTCfuOUzk6fVgtgSz+PieBZOQxwrY
 XgXLfWqonf8JqZmGShMD1nDg9i/Fm/2huwDbHZr5cJEj6UWLPSN+ogBqAxDLojPBVS/J
 5IMA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774021021; x=1774625821; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SP1tkMmpAb4xcYlyw0o8SQilnRArOuWj5BE9yWJumPg=;
 b=IZH1R5+UACucH51uKlxm/PgL+LIkqThHONIqjvB6izRZeJW7JpvOKI6wIqGxrKJPwH
 C0LgfGKfJzaWaEA9DfBagqvGFJmQ5ea6TuzyfAfeBM/Q9XGdwiJV8XKrLJ0UhZvmXEvY
 6sMAqpVECG3UFq7gRhmB/kYdNgvyjiMUtjV6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021021; x=1774625821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SP1tkMmpAb4xcYlyw0o8SQilnRArOuWj5BE9yWJumPg=;
 b=hVL4dyBLee5AGz2Jxs6t3SLk+ldZdv/jDMpeJLOeYKmRDe8wdH0AnuIAeCgkicc7XS
 91Yh5lZ1/25s1Zo53qbmUn9Tn4izQ8bs/aXsZKnXII4sh/Is8E9HyRU3YfgPAyFMZD0B
 wGzL0aZ8lrYLuOkek4xT8iBR0InsQN9lb6JJMbBjU5N1/snBDYNqOvuhO14yDWxyd5Wu
 4483pWAv2rc8Q0/g1H+XQmL5KDfQpjLb5Npn9jREYpL/5hZNXXCs8BF10V7XKd55Hs4+
 cW7aZNeK3bzTBBw8xKH5shBcU8EsrIhejHybFQJrkN9BgBdbEHzzhw/PYed7Wjm9k27K
 dWXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgB4im6WXOs+D9hrKncWBLl9Ikz6bxSaoDrFvrJm3q1QQnvETFtfsRcLtVn2nhRT9cCbA=@dpdk.org
X-Gm-Message-State: AOJu0Yzv3kILQotBtF6FN5aglpkeuwyZBvxnIo56URD1WJryPHikoL6B
 GID+bzSTD8RqO25KFM0odBDA7p0KaZsxjCtsRdIdA/jcyICNN+cpUDWTsM1QO7/D/K3kn+fNaE/
 2QdZBgBbfcdvxWgya/1eSBtR8dmwMwLzryLObyUgx7g==
X-Gm-Gg: ATEYQzwbRnHdkX3LX8NooufGv1iXe+FP2G5ankQbbfYabkDEFwfsiytAKmV2gjTgZVj
 pqaVZArgq2hFdwelxup23q1TeMMatXM7hbNcmNfvQN8WK/TCbzYACyVKm2hEBmWZa3mzOKSsQZt
 7cZsgj7lC64n/mtKsgPCeqnWt42T7BEvZ8JeTX7kJkc5nEiRoy+HfLK0Vsi8yS7/UQQLgrHUHE8
 WUNUY5wmoH2w3SdZSyCNWFf4l6eQDNguEZMEy26FDJ9peaKlUaTYrF7QZY2fCvwFvHnQCrQDcCI
 ikvtq4g5Xtc+yf0uOOfMt00cKPoqHBozwk/cUJwkJg==
X-Received: by 2002:a53:c9cf:0:b0:649:b4cd:b539 with SMTP id
 956f58d0204a3-64eaa70910emr2567630d50.35.1774021020719; Fri, 20 Mar 2026
 08:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260313155601.112819-1-dmarx@iol.unh.edu>
 <20260313182240.130379-1-dmarx@iol.unh.edu>
 <2e433dc1-2dbc-422b-911f-bb633350fed7@arm.com>
In-Reply-To: <2e433dc1-2dbc-422b-911f-bb633350fed7@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 20 Mar 2026 11:36:48 -0400
X-Gm-Features: AaiRm52XrV02cuXg1Xi9s5K80ATs0cFzRBcfSincTzCNMjq0VaybVc7M84o_5IE
Message-ID: <CABD7UXMOpsNWjF4fVR5RHAYXR=-T-o28-VpogHZ2RtN4L3g8oA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update overall result pass/skip logic
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

Fair enough, I wasn't sure if reordering the enum would impact
something outside of the scope of this patch, but since it doesn't
that makes it easy. I'll submit a new version
