Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7292610F9302
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 730AC40275;
	Wed,  1 Apr 2026 00:23:41 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 5EF2B4026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:23:40 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso5548353eec.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774995819;
 x=1775600619; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmvN0zhJ8HAxghrdYc4vMr9WJJNrf9ElQVBjNKaqNEU=;
 b=saT0RVSwP9S+HtGI67oh/Gbl1EfagKrvlRY218FWcjTvxl1SSxXrd/Cm6cVG49mmOo
 9O2RMSM5UL0GwCoisBbwuN+bKhTg5fc8RQ0b4vA+THxTG6sq3j8VUGb7hxIGo+uqEvP2
 WG20vPychtiZwQRgPK4f+M4nMzr9lr53KXiIDPRVzp/yeBOLC9HOsOzULTMPZhPnm+pM
 /zwteWGTnnBA5O++Jmdd7djSleHNijw8x0TocYx/QEu4/rOJm5De6nWtBeMvbpJR+Suq
 IHTIhkLb0uUdW20eLmegKk3ydQ/hltOj3uNvQjbI2ornQDHoE7440whezGPRAkMHTFEb
 6gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774995819; x=1775600619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AmvN0zhJ8HAxghrdYc4vMr9WJJNrf9ElQVBjNKaqNEU=;
 b=tJ0lOilsQv6LGFm0Qc+INIF3B+f6onW6IPjMo42aW58jZjSQJflid+4jUJtQPRe2mI
 +ZOmUChq1kCFTckbcDmpTM0NA712A6XwTZCphBrrVWxuQDDY5Cd1HEs3wWktp6mRh9pQ
 xEQgLT6Qf/19bDz3YGl5V9j/kxGlr7s3mPfNTGRUYpQM1ZLxnD1xqaymep4dtjWd4mju
 y4grOyymJ4C+7ReqmSRphnEHQIr5rhh62zb+TzFtz5/b3yIKiz0gr3djPUXTOtcOmUCU
 msmhduWoV1T7JCC6rH6vaVlZGICpumRBlG93C6Itb/K3AIyBexZWFnvEffi0EEr7pY2/
 oxqg==
X-Gm-Message-State: AOJu0Yzdv41zp8KG5vBvgRd8eiBf0X8AITOHwsiTW0QdJ+BLSps7+cPm
 ddILauBJ5oPVajuVvGbtdC168rJejazyNRnOvocKRZ1uKfwTCX872OcohV7FgVAz/UQ=
X-Gm-Gg: ATEYQzyY7JMiHhMkWfdjZrmG0MGcJa1c/zE2/ymN6MrtYiU/U/G2+2PYjbowKr9KDDL
 y3PdOsE2UL7g75OUvF21yqtX32z/Uz/vrwAzAn5YLyIUjto4ht6urPWHJCPOXBaAuH5cnaRucb7
 WlnYryKeZpkZeGdIzpiwa/TisQP2JIHM+z6bJrK5N5C8Y0kOd59F/5FIys3rQdHvIn9uB/h8dY5
 ueerEtlMjMf6dLq5eoMSB+U4UZq5Z3tOFyoSDX1w/gzQUJ7UHsRSryKHdAuzaVCcESaQM24Xcsx
 cHrXKabLu7gcVwpwXz6QKtTmGG+dfUA1U1iBuNotmcITWVRWk2aux/c2Ss/XNIYhgGV7r/vblAu
 yr4A6zO71yTsDakEL1r4nx5ljIPyBWoEhI6cyJFmbc1LkWGfjLGjfpue/1Kkubjzi4VRuUhP9Db
 k6jtyi+5bukulXKukqmfy9jKo2cNv1xn5u1dY=
X-Received: by 2002:a05:7300:a897:b0:2be:1cb2:3a6 with SMTP id
 5a478bee46e88-2c9334b62d3mr580368eec.33.1774995819361; 
 Tue, 31 Mar 2026 15:23:39 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c41c1547sm11073424eec.7.2026.03.31.15.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:23:39 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:23:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xinxin Zhao <15957197901@163.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] vhost: Fix the crash caused by accessing the released
 memory
Message-ID: <20260331152336.48a9d294@phoenix.local>
In-Reply-To: <20240625093149.63247-1-15957197901@163.com>
References: <20240625093149.63247-1-15957197901@163.com>
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

On Tue, 25 Jun 2024 17:31:49 +0800
Xinxin Zhao <15957197901@163.com> wrote:

> The rte_vhost_driver_unregister() vhost_user_read_cb()
> vhost_user_client_reconnect() can be called at the same time by 3 threads.
> when memory of vsocket is freed in rte_vhost_driver_unregister(),
> then vhost_user_read_cb() maybe add vsocket to reconn_list,
> the invalid memory of vsocket is accessed in vhost_user_client_reconnect(=
).
> It's a bug for vhost as client.
>=20
> E.g., vhostuser port is created as client.
> Thread 1 calls rte_vhost_driver_unregister() to remove
> the vsocket of reconn from the reconn list.
> Then =E2=80=9Cvhost-events=E2=80=9D thread calls vhost_user_read_cb() to
> add the vsocket of reconn back to the reconn list.
> At this time, after thread 1 releases the vsocket memory,
> the socket of vhostuser reconnects successfully,
> "vhost_reconn" thread will access the released memory.
>=20
> The core trace is:
> Program terminated with signal 11, Segmentation fault.
> The fix is to perform a delete operation again after releasing the memory
>=20
> Fixes: 451dc0f ("vhost: fix crash on port deletion")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Xinxin Zhao <15957197901@163.com>
> ---

This patch looks like something that should get fixed.
But the current patch has some commit message issues.
AI review had some observations=20

Review of [PATCH] vhost: Fix the crash caused by accessing the released mem=
ory

The use-after-free bug is real and the fix is correctly placed =E2=80=94 the
reconnect entry is removed before vsocket is freed, and by this point
fdset_try_del has ensured vhost_user_read_cb can no longer re-add it.

Warning: Commit message says "perform a delete operation again after
  releasing the memory" but the code removes the entry BEFORE freeing.
  The description contradicts the (correct) code.

Warning: Fixes tag uses 7-char hash, DPDK convention is 12:
    Fixes: 451dc0f2d943 ("vhost: fix crash on port deletion")

Warning: Subject should be lowercase after prefix and more concise:
    vhost: fix use-after-free on client reconnect during unregister

Suggest this:

vhost: fix use-after-free on client reconnect during unregister

When vhost operates in client mode with reconnect enabled, three
threads can race: rte_vhost_driver_unregister(), vhost_user_read_cb(),
and vhost_user_client_reconnect(). If vhost_user_read_cb() adds the
vsocket back to the reconnect list after unregister has already
removed it, the reconnect thread will later dereference the freed
vsocket memory.

Fix by calling vhost_user_remove_reconnect() for client sockets
with reconnect enabled during unregister. This is safe because by
this point fdset_try_del has completed for all connection fds,
preventing vhost_user_read_cb from creating new reconnect entries.

Fixes: 451dc0f2d943 ("vhost: fix crash on port deletion")
Cc: stable@dpdk.org

Signed-off-by: Xinxin Zhao <15957197901@163.com>
