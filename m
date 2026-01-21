Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E00CD262B7
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 04:46:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6F1E41132;
	Wed, 21 Jan 2026 05:46:39 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 3AFC14026C
 for <dev@dpdk.org>; Wed, 21 Jan 2026 05:46:38 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so5196199f8f.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768970798;
 x=1769575598; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bk3aO4PlPj2b3e8OYHgCvta/byT2frik5o7z63qRHk=;
 b=l+HkhkoFUC7/rbMuZMqwlQDrWQVfn25+gk4XSL3LNkRUD3aKv1rQsfKoISScmbOPqB
 ggQkScJQjAnJCcZfCrOAL7CGLBOa5iFIi5D7wSZdJCAUF1gflJAkoBjot8+QsKw6vtB5
 GN+lXHaXwZUQFxa3nAMUKITZ4r4ZTuA64qBMCbQbSWxauPlwsd9iXkNGBH1B+QPw/AOI
 2OCfBU4+JGtMBfIGg4TFGZ4omSOoNFZhReKuV0LfCvcS5ATRl6R6iIJa8llkSGCyGnAf
 9ePDjGdvnqkpf+B3ebZ2zZGeubrfNKWtkIr8wx06QDl7GXOc7Tf8wOEDYKjkHaWY2TnH
 4BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768970798; x=1769575598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bk3aO4PlPj2b3e8OYHgCvta/byT2frik5o7z63qRHk=;
 b=vrSTeo5VhJ3YK2xLDjCsRxlc7iTJ3fM5p70gAteemLqc9jTwmWPIJ9TuSx3MLXFTZG
 Nl4kWu3tjeGIluCzDISC2XoUZVzplZXizWBV6/52xe19QKP1joX5dYa/XbXsrjWov3wb
 LV24kp4h5PPzxmYxr+Iu9rpKQv0zqJQAzHt/450jCnkAYunmOMAxd9FetTirYrt5TVrA
 B0zWpQiilKcX6ljutnQpjcCYA/T5U/0YHPzBkb1vhSUMD9s4zcRlH1gli8v1+cVNPbzJ
 hCnut3Yvt/slAIzKJmgT1W4twk2qnvgHmV0pq5xfq6sPRk7HQdd/sbnKFrswU4c/D8MV
 Nqmw==
X-Gm-Message-State: AOJu0YwGspdqXNx40PfF5HvPfQ6PhyfnSplHwhPhUYd0AXpBlLrGDe1E
 hW7Fvbhyp++AQfWhYJIPBbfr9+C3Mkfw7htpItA9e0GKjzcSzoxbBPa3ZDE7YD8+PjM=
X-Gm-Gg: AZuq6aLEUBMje495t9NUIUCeiX8Nugj56fP/dYsiWnm+qorunejTLj2P9oier/LwjDd
 GEFnEspQojDywsOk33i/BITN2NuMrd0/qxrKzkcyStMdmIAKG//IP8762MrqnsaQlDM6Sg9rsre
 jJyKjQMRbJyGgPqyyhSOgv0SIKDK/9ykCaurXF9PkGZd0iom0snu3l76hR/1MxBx2L1uioNViL6
 4u65VVTCnjfmTr1MIJWOROCHBl+mHGFdDq7GdtxHHs2pUfGgh3oIAwrpO825FpnRX/pfMuL1X9Q
 tDJho+EXTrDCZK6c/J0jnejCrn2iNQ2sxVC+1mSp+F2A5RjKAk+zNtvz+HYpIpBF2Ik7+I9Y1Vw
 Mp9+f2Im9D9izBXmilmJiSCsR41PGSjKoT4aUUQDOnbyzGgtsaMjPCnItbJxF4NiVR1c0iFHBsp
 hPZHw0lcz9oG37fa0w+FLtemvnSwsvaE9HlemOPu9VaOmsQR4MKGC4
X-Received: by 2002:a05:6000:1448:b0:42f:f627:3aa3 with SMTP id
 ffacd0b85a97d-4358ff398b2mr7413212f8f.56.1768970797693; 
 Tue, 20 Jan 2026 20:46:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997ed8bsm34071607f8f.36.2026.01.20.20.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 20:46:37 -0800 (PST)
Date: Tue, 20 Jan 2026 20:46:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon
 Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v2 1/1] net/nbl: fix hardware stats interrupt nesting issue
Message-ID: <20260120204631.32feb3bc@phoenix.local>
In-Reply-To: <20260115061807.65832-2-dimon.zhao@nebula-matrix.com>
References: <20260114081558.50370-2-dimon.zhao@nebula-matrix.com>
 <20260115061807.65832-1-dimon.zhao@nebula-matrix.com>
 <20260115061807.65832-2-dimon.zhao@nebula-matrix.com>
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

On Wed, 14 Jan 2026 22:18:07 -0800
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

Queued to next-net.

You may want to consider the suggestions from AI patch review

### =E2=9C=85 COMMIT MESSAGE

**Subject Line** (Line 29):
- Length: 53 characters =E2=9C=93 (limit: 60)
- Format: `net/nbl: fix hardware stats interrupt nesting issue` =E2=9C=93
- Lowercase with imperative mood =E2=9C=93
- No trailing period =E2=9C=93
- Correct component prefix =E2=9C=93

**Body** (Lines 50-56):
- Lines within 75 character limit =E2=9C=93
- Doesn't start with "It" =E2=9C=93
- Clearly explains the problem: interrupt nesting from mailbox operations =
=E2=9C=93
- Describes solution: dedicated thread eliminates nested interrupts =E2=9C=
=93
- Good technical rationale =E2=9C=93

**Tags** (Lines 58-61):
- `Fixes:` tag with 12-char SHA and exact subject =E2=9C=93
- `Cc: stable@dpdk.org` present =E2=9C=93
- `Signed-off-by:` with full name and email =E2=9C=93
- Correct tag order =E2=9C=93

### =E2=9C=85 CODE CHANGES

**Architecture**: Producer-consumer pattern using pipe for interrupt-to-thr=
ead communication - solid design =E2=9C=93

**nbl_dev_thread_hw_stats_task()** (Lines 75-93):
- Worker thread that reads from pipe and updates stats
- Uses `read()` with proper return value checking (line 86-87) =E2=9C=93
- Clean loop termination on pipe closure =E2=9C=93

**nbl_dev_update_hw_stats_handler()** (Lines 95-109):
- Interrupt handler now writes to pipe instead of direct mailbox call =E2=
=9C=93
- **Line 106-107**: `write()` return value captured but marked unused with =
`RTE_SET_USED(nw)`

**nbl_dev_hw_stats_start()** (Lines 213-229):
- Creates pipe with error checking =E2=9C=93
- Spawns thread with proper error handling =E2=9C=93
- Cleans up pipe on thread creation failure (lines 124-127) =E2=9C=93
- Sets fd to -1 on error - good defensive programming =E2=9C=93

**nbl_dev_hw_stats_stop()** (Lines 336-350):
- Cancels alarm =E2=9C=93
- Closes pipe to signal thread exit =E2=9C=93
- **Line 145-146**: `close()` calls without return value checks
- **Line 149**: `rte_thread_join()` without return value check
- Sets fd to -1 after close - good practice =E2=9C=93

### =E2=9A=A0=EF=B8=8F WARNINGS

**Warning 1**: Line 106-107 - Write return value handling
```c
nw =3D write(net_dev->fd[1], &notify_byte, 1);
RTE_SET_USED(nw);
```
**Issue**: In interrupt context, the pipe write is intentionally best-effor=
t (if write fails, one stats update is skipped but alarm reschedules). Howe=
ver, this should have a comment explaining the intentional ignore, or consi=
der at least logging on failure if safe in interrupt context.

**Suggested improvement**:
```c
/* Best-effort notification; if write fails, stats update skipped this cycl=
e */
nw =3D write(net_dev->fd[1], &notify_byte, 1);
if (unlikely(nw !=3D 1))
    NBL_LOG(DEBUG, "hw_stats notification write failed");
```

**Warning 2**: Line 149 - Thread join without error check
```c
rte_thread_join(net_dev->tid, NULL);
```
**Issue**: Return value should be checked per AGENTS.md guidelines on check=
ing system calls.

**Suggested improvement**:
```c
ret =3D rte_thread_join(net_dev->tid, NULL);
if (ret)
    NBL_LOG(ERR, "hw_stats thread join failed, ret %d", ret);
```

**Warning 3**: Lines 145-146 - Close without error check
```c
close(net_dev->fd[0]);
close(net_dev->fd[1]);
```
**Issue**: While errors on `close()` in cleanup paths are typically non-fat=
al, AGENTS.md emphasizes checking return values. At minimum, could check fo=
r -1 and log.

### =E2=9C=85 CODE STYLE

- Line length under 100 characters =E2=9C=93
- Proper indentation =E2=9C=93
- No trailing whitespace visible =E2=9C=93
- Variable naming conventions followed =E2=9C=93
- Comment on line 144 uses correct style =E2=9C=93

### =F0=9F=93=8B FINAL ASSESSMENT

**Errors:** None =20
**Warnings:** 3 (return value checking in edge cases) =20
**Info:** Excellent architectural solution to interrupt nesting problem

The patch solves a real concurrency issue with a clean producer-consumer de=
sign. The interrupt-to-thread communication via pipe is the right approach.=
 The warnings are minor - mostly about defensive error checking in contexts=
 where failures are unlikely or non-fatal.

**Recommendation:** =E2=9C=85 **APPROVED with minor suggestions**

The patch is fundamentally sound and ready for merge. The suggested improve=
ments around return value checking would make it even more robust, but the =
current implementation is acceptable given that:
1. Pipe write failure in interrupt context has limited recovery options
2. Thread join failure during cleanup is rare
3. Close failures are typically informational

**Priority for improvements**: Low - consider for follow-up polish but not =
blocking.
