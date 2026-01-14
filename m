Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F796D38FF3
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED70F406FF;
	Wed, 14 Jan 2026 18:23:13 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id CAE504027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 18:23:12 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so565605e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768411392;
 x=1769016192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/voDz3F6XA/aWKryxp7Xxm6BAFmcpYjgoZAfWSwvSk0=;
 b=j7m3h30CWsy+dElHuNDhAAd2we5hdL5bjW253k2LSP2uQCeCDeYKV7td7e9W+vMwcH
 udJ0Xsk6zqr/3CXgx6iqmNQnwa+HBsgsPi8NebnyYmXgQBuCfKAaqQSUagVoxiAkj3Fp
 4EDvGC/NJ2Imw6uXWqnAA/SUdEJpaGbI2hsao0g0kuCabrfku4HpZecJ7PuUQAXWR7nR
 7sX+hYeeirRh40CHDogr7Lq2ipPmTnqUrGQHPce8aYmaQexACIrjgIOA/z9GDqqmh6Cu
 XwoTppO5Baj/nzm/KtKRICmvRUGvG6fFKTiJPEcXHaIVXI8PeCYJ0AXDstTAwd/kR5ad
 Ideg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768411392; x=1769016192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/voDz3F6XA/aWKryxp7Xxm6BAFmcpYjgoZAfWSwvSk0=;
 b=Bi97cyuBo+ABm11FsEviBGNsCcYM4EcJIx4dtS4U17awkVc5qXbeRYoMoJMFjCTIco
 1Kp1bXVZ9BPWO/xjzK7uRH8xyezxf6hzVD47/rrWoPoKbHGGVoOulG+F0N8rc+UEXBkW
 /uH7ElbKDN9Zh3OPia1Z4aYNm0JdTzLsfydrGN3TzlzocA0IO4ifGXavNU2NzahIuXhx
 BIaHuDEkai2F1y2XEgWrXsCPnQp0KkS7685kecuKxN0l4qb/924AZF1G5qANe3lf6B67
 ICF9gdoIN843CmPXp2tV1ScjXwpQJq2aAI7Jv60C6E686QRSrOxw3lV6Cd4RJU0UMrUR
 krKQ==
X-Gm-Message-State: AOJu0YzdVgjnyL7u38xZUQAEGyjPxNXcWC53sDtlaa8ENgqbT3zPGWPI
 Tk9Q4hHuJqbKMdkvEnssQq6gVKn35mR8Oy7mCy8O6a1ukx5Kg4JMwgT0TFEq0ljGAgSNg3kCtxI
 IWIko
X-Gm-Gg: AY/fxX6xQe/cDIxp12OKB8TQ+C5fKisp1yK6Mt2peozxUlz4SRL3sXum2YheNTikit9
 W9OAxpWNj/UpeWAVDua4AHvl3FS2MgkqzYd3W8KlIWXx965UOJU/zJy0/2I8FlKExWeCTS1FG+a
 /U6TdiVsSds0ePB+eYckZqDywfy0kF6ReiDigUF3v1+bJK2T7kReQEIfzcHbVyx6XTuTPJMHh+S
 EFJ8q0IyIgLsrMgS80JfUZFMBiOHjOeFu69/HFVOoQCpgNqk+2x2KzRbQ8Tz0T5t5hiVDFjdEN1
 aDwAVY0btOW/4THA9bJH6m/TGo76M8iZE9LO60N64pUh7DIkOWJv3b7qMP+VXafff07Ew1tEH4F
 NZgUTaTcMky0t6vsXk2TXdGWjdmpFuFM4zbeS27UfkbVfeUPDJzBmMZaQgZddM1wkiIbitRtivR
 dOLSlDqo6maZFggM97kutffNR65TWDyRDSrJgoo4czEaBcmBxO9xlXNRfZvsLNNA0=
X-Received: by 2002:a05:600c:c0ca:b0:47e:e575:a33e with SMTP id
 5b1f17b1804b1-47ee575a747mr22176755e9.33.1768411392295; 
 Wed, 14 Jan 2026 09:23:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428bc400sm2107075e9.7.2026.01.14.09.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 09:23:11 -0800 (PST)
Date: Wed, 14 Jan 2026 09:23:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon
 Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix hardware stats interrupt nesting issue
Message-ID: <20260114092301.62d942c8@phoenix.local>
In-Reply-To: <20260114081558.50370-2-dimon.zhao@nebula-matrix.com>
References: <20260114081558.50370-1-dimon.zhao@nebula-matrix.com>
 <20260114081558.50370-2-dimon.zhao@nebula-matrix.com>
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

On Wed, 14 Jan 2026 00:15:58 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> The timer interrupt handler periodically queries and updates
> hw_stats via mailbox.
> Since mailbox operations rely on interrupts for packet reception,
> this causes interrupt nesting.
> To resolve this, trigger a task from the interrupt handler and
> start a dedicated thread to execute this task,
> eliminating the nested interrupt scenario.
>=20
> Fixes: c9726a719ca1 ("net/nbl: support dropped packets counter")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

Automated patch review has some good observations, please address
these and resubmit.


## Patch Review: net/nbl: fix hardware stats interrupt nesting issue

### Commit Message Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 PASS | 51 characters |
| Lowercase after colon | =E2=9C=93 PASS | "fix hardware stats..." |
| Correct prefix | =E2=9C=93 PASS | `net/nbl:` |
| Imperative mood | =E2=9C=93 PASS | "fix" |
| No trailing period | =E2=9C=93 PASS | |
| Body =E2=89=A475 chars | =E2=9C=93 PASS | All body lines within limit |
| Body does not start with "It" | =E2=9C=93 PASS | Starts with "The" |
| Signed-off-by present | =E2=9C=93 PASS | Valid name and email |
| Fixes tag format | =E2=9C=93 PASS | 12-char SHA `c9726a719ca1` |
| Cc: stable@dpdk.org | =E2=9C=93 PASS | Appropriate for bug fix |
| Tag order | =E2=9C=93 PASS | Fixes =E2=86=92 Cc =E2=86=92 blank =E2=86=92=
 Signed-off-by |

**Commit message: PASS**

---

### Code Review

#### **WARNING: Unnecessary cast of void pointer**

**Location:** Line 76 in patch (new function `nbl_dev_thread_hw_stats_task`)
```c
struct rte_eth_dev *eth_dev =3D (struct rte_eth_dev *)param;
```

Per AGENTS.md, casting `void *` is unnecessary in C. Should be:
```c
struct rte_eth_dev *eth_dev =3D param;
```

---

#### **WARNING: Unnecessary variable initialization**

**Location:** Line 101 in patch
```c
ssize_t nw =3D 0;
```

The variable is immediately assigned on line 104 (`nw =3D write(...)`), mak=
ing the `=3D 0` initialization unnecessary. Per AGENTS.md guidelines on unn=
ecessary initialization patterns.

---

#### **WARNING: Resource leak on error path**

**Location:** `nbl_dev_hw_stats_start()` around lines 213-224 in patch

If `pipe()` succeeds but `rte_thread_create_internal_control()` fails, the =
pipe file descriptors are leaked:

```c
ret =3D pipe(net_dev->fd);
if (ret) {
    NBL_LOG(ERR, "hw_stats pipe failed, ret %d", ret);
    return ret;
}

ret =3D rte_thread_create_internal_control(&net_dev->tid, "nbl_hw_stats_thr=
ead",
                                         nbl_dev_thread_hw_stats_task, eth_=
dev);
if (ret) {
    NBL_LOG(ERR, "create hw_stats thread failed, ret %d", ret);
    return ret;  // <-- LEAK: net_dev->fd[0] and fd[1] not closed
}
```

**Suggested fix:**
```c
ret =3D rte_thread_create_internal_control(&net_dev->tid, "nbl_hw_stats_thr=
ead",
                                         nbl_dev_thread_hw_stats_task, eth_=
dev);
if (ret) {
    NBL_LOG(ERR, "create hw_stats thread failed, ret %d", ret);
    close(net_dev->fd[0]);
    close(net_dev->fd[1]);
    return ret;
}
```

---

#### **INFO: Thread function return type**

**Location:** Line 74
```c
static uint32_t nbl_dev_thread_hw_stats_task(void *param)
```

The `rte_thread_create_internal_control()` callback expects signature `uint=
32_t (*func)(void *)`, so this is correct. Just noting for completeness.

---

#### **INFO: Consider adding missing include**

The code uses `pipe()`, `read()`, `write()`, and `close()` which typically =
require `<unistd.h>`. Ensure this header is included (either directly or tr=
ansitively through `nbl_dev.h` =E2=86=92 `nbl_common.h`).

---

### Summary

| Severity | Count | Issues |
|----------|-------|--------|
| **Error** | 0 | =E2=80=94 |
| **Warning** | 3 | Unnecessary void* cast, unnecessary initialization, res=
ource leak |
| **Info** | 2 | Return type note, include verification |

### Verdict: **Needs Minor Revision (v2)**

The patch logic is sound=E2=80=94moving the mailbox-dependent stats update =
from interrupt context to a dedicated thread via pipe notification is the c=
orrect approach to resolve interrupt nesting. However, three warnings shoul=
d be addressed:

1. Remove the unnecessary `(struct rte_eth_dev *)` cast
2. Remove `=3D 0` from `ssize_t nw` declaration
3. Add cleanup of pipe file descriptors if thread creation fails
