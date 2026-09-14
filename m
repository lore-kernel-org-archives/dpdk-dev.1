Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01316C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 21:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCC8640DD7;
	Mon, 14 Sep 2026 23:21:25 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 897B040A6B
 for <dev@dpdk.org>; Mon, 14 Sep 2026 23:21:24 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd77300816so522035ad.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789420883;
 x=1790025683; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/T4aXB+H74vJpZBnfJPTHs7Me3us7l7W1FqD6vltGis=;
 b=pe0L6E+F25W6qFXEqNyypmEp3ObP1FxRj1m5AOLNq0JNIKcx/8k1PBzmGVeip87Mr7
 dQtnJ3XrDF6pnGKsjhLeSN/i2gNms3ihOr22emL9Wpm9nNhn1ZEzSra9ezDCtCtwzC7e
 zU7iOobMW398+DB/ZmS7rUVZUoprj9ql6iF8Dl5gzVd1mZrsgvpsGmwe4Qiwx4PuglD1
 RASUqfQqiqbWQ/AjJzQbDMJuThwh3QQL72Ow/n56jwG02V1j6lApwmqjXhLBdiijmkbH
 h6JRzJu+EaxRM1EwRL27165ZXsDjbnUlWvqq1yBxt+QGzsE+Pv9awrXgBSx5rhmu7xEx
 cmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420883; x=1790025683;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/T4aXB+H74vJpZBnfJPTHs7Me3us7l7W1FqD6vltGis=;
 b=KMejPpK0ZUNhMd9Qw4JwAnk7IkQtHoQdGm7+UUKgKgMQGf4/QU0cPkDXec3EXw8cQV
 fK+kWdr/Z19ONWhJdaZxIig8/iZy3O1+ESTEDKFTSJCVTNmvJD8Nu+XODs80yh/BMaIf
 5C7ju9aFXKlBs9u7d7wX3Y+4B8wQBDHWPaXsuaExOwgSY2RQLKmbZMHOMoSyL/2eSDAX
 4aHV0Fw6kN+0De8hCSkfhU8bJ6tL1azHI2W25TI3mckGU5OjEttcCEIWGXgLhOqhqxPO
 Bt8Ty3+vBzj9LOs7CZ+XQphp+zhr2lTCkNkBFHZycUTf3w+KS6pYLZ1qONPu9N0oxU2Z
 1VmA==
X-Gm-Message-State: AFuF++kDcs1/b777o71lH2BzsMmW0afqtndglj4Atua0uVghNNcC8n9n
 6RzjCOX7/F1UIM0gJPQlkA0C4WjHCuX5y26t/4a/b5boujFd/6B8PsgLSO9FMdYLBICyFc6kw5h
 QCya3uDo=
X-Gm-Gg: AYBFou2otVnydb9+eVCAKVeD2Of3AX4vnZOvhymhpr6Xgy84XHHksJIuU+nhKreyOMY
 od2W13nhG+F9QW2OgwKIWG8ttVTujDll7317Qual8UEm1wFZEqGnfaD7N+cFEtQTX8aIhlaQ1An
 HvF21tJNxR43DqcmZu+gcuJPwPuZZkOYBthiFklutKOgIRA8N/gjQcnPu421jMaR9l9y0hzqkF+
 4+zbQK4G8d6icT8jJiUpYM97fp22zcEwG/umoTLSW1JFFEeDlQ7R393eHm03qjgvwf9pND6IHq9
 KYEXWnPE5FzrBPpWR7nQn3IagDRG9dHTm9YFNKj9dWQztYY/68h6t9xlNjtBN6Wk2LFvDpNrQxx
 okbr+IAv/j8kNGm3nv7EucRub5RrafgzQzZD6HfFXLmM4QI/0cIEi/xSrgWDOT1z+NBFCU0GX0Y
 uXB8cOVLIv/esvLBOYXvl3VqRkR20XKeSpwTuH6b2o+kSdbtCUloXzmO32guCTc71deQzA2D5Vn
 iB2YcWuXmmGaQO+TCWY/zBORmY7ILxk9RNGHpNKiQ==
X-Received: by 2002:a17:903:1ace:b0:2d8:d4cf:fe48 with SMTP id
 d9443c01a7336-2dd76528260mr13384065ad.14.1789420883593; 
 Mon, 14 Sep 2026 14:21:23 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfc2d3bsm56827875ad.48.2026.09.14.14.21.21
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:21:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:21:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/7] fix XXX_DEBUG warnings
Message-ID: <20260914142111.52408ad7@phoenix.local>
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  4 Sep 2026 12:12:35 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> I recently modified my build test to automatically enable all
> DEBUG flags. This is because developers often add debug code,
> forget about it, and it bit rots.
> 
> This patch series fixes all the places where #ifdef XXX_DEBUG
> code was present but would not build without warnings.


Applied to next-net.
Now all of next-net builds clean with this series.
