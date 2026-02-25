Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB1EFD45F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:23:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A512940279;
	Wed, 25 Feb 2026 23:23:16 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id CEFE1400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:23:14 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bdc47747e2so169688eec.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772058194;
 x=1772662994; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHqm8Z1ucT+qAMNXTlRvI7NoGPbNg7ZVEhYXDFtyPzA=;
 b=A8fclVDK8uO9cEtBteRsHAfozbL2KrUTa3K23+oYt3LIIfITlXOPnQUlbMEuQNSNBt
 wpWwrB5+CkpXedQxiRoRA1ol+Gshpco7ja5ll/dIT0TQPZ25CH7GJC+WzIDpil4oa5k4
 LQp/m5h5jKoYPv8qN0AAvu3WmOjpbhfrBirntPQCp4i2m8hsOlpGuBzTWSSN3OWHSDV9
 ZIaHJTK+h64bfDx88znNBCcPKbRHr1WJovKT7qxncjyq1MSON6MH7mvqVTScoMISDkHG
 i6BgAUX+0FMk4mjzqi4ySW8Ac+7Cq7gocz9aWrg68s2NRIqY5ik7F7+y3d9s8baSxTK1
 6Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772058194; x=1772662994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aHqm8Z1ucT+qAMNXTlRvI7NoGPbNg7ZVEhYXDFtyPzA=;
 b=l/B3oyonQx6ySsnIZbz8r0jOOgg24ki+wWnAkyafOWv1Kf4RuhkUYcrrzdN+JmpUvJ
 ywy+hESJeASzTtD1EERRDdqH8vq1hH4Z+TvBC0oyLxxwoc6JzO6LFJjUkzi0N9acnLhR
 rX8N6iCyVRSZlq/rrxvoLGPGp5zaBvpwKu/TVPZgUuZ2WUkBGDWP3Y6ABwcvW85aNPm9
 anRYA4n/HO9RQpK5h38IxNjxBWjo7mLSDrLe8fOqaCkBMGdOJoLIowVRqQk6joEFktv8
 ZCqwXSIXjVkM7BSUCvq4V2ImVk01ucxlgPpskLqd9NFuQkP2nlV+navOQ5WikYbeJxhK
 McKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMrFivSboodlCM5mkemiwX/YQhyoJ8EGLyXw52/b1Z/0wyhnLHjEm9ol5dNKBCpyXEGSw=@dpdk.org
X-Gm-Message-State: AOJu0YzptmAOAT6hXTmtJfhor/odreSFE1HQuFXiVhBCphsDReH83EpE
 ObN36kwGOxMDKzCHVrdsKodNW9W064aqCS3L9Z/m/AsZaeks1Gd6U+9Q2FRFYb8bsyc=
X-Gm-Gg: ATEYQzz146b2rhet7NqiYkhZD8hoC0F5w7vjyp97i2W07t7iNR/eVxVGA5BCCYn1M1F
 6sMEBCwfaWCP9g3Ie5F/+y/+TtPoU8oP53NpBmu3ivbIIBOvgq9BdRF/7YToQZTE6d26rEpV/kh
 cer6HOTnOjCRcWfk+zo0lVwdXawmQcS5ogX+F+XFZ2tAVL6XFQAHARMqFp+SmEaBZOfr7ssn+Bw
 jq4vsQXGAPJNbXcDEnwyynCHgrNg0t6c+W73AI02lXMxXl42wOg0kRpsoEjyylpzlXzup/3xw4o
 XrOBpFx07F069XIoGFn5CXnpLfXWaNCi+yB2DYQc2gnvnQu6rwSlfxM0j7aaGQ9/6vDE5fTlYEP
 DuZaeJmGsezH5tVvKwGpJU+SGVaCXR5rElFd0wIno/2Nm1G4qbh89t+huG4h2q1aikgUrUf8c60
 ULmtzui1WlVtjG8ktTCZjiizVWGwbdbfm9ySq82ACQGb/3+bK80QqwDSwN1bwVpr73
X-Received: by 2002:a05:7300:538e:b0:2b7:1abc:a6eb with SMTP id
 5a478bee46e88-2bdcbf4440dmr841272eec.7.1772058193592; 
 Wed, 25 Feb 2026 14:23:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1cf0115sm267044eec.8.2026.02.25.14.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:23:13 -0800 (PST)
Date: Wed, 25 Feb 2026 14:23:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Peim <maxime.peim@gmail.com>
Cc: Wisam Jaddo <wisamm@nvidia.com>, dev@dpdk.org
Subject: Re: [PATCH] test/flow: add support for async API
Message-ID: <20260225142310.51f75f4d@phoenix.local>
In-Reply-To: <20260224105712.937285-2-maxime.peim@gmail.com>
References: <20260224105712.937285-2-maxime.peim@gmail.com>
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

On Tue, 24 Feb 2026 11:56:47 +0100
Maxime Peim <maxime.peim@gmail.com> wrote:

> Add async flow API mode to test-flow-perf application for improved
> flow rule insertion performance. The async API allows batching flow
> rule creation operations and processing completions in bulk, reducing
> per-rule overhead.
>=20
> New command line options:
>   --async: enable async flow API mode
>   --async-queue-size=3DN: size of async queues (default: 1024)
>   --async-push-batch=3DN: flows to batch before push (default: 256)
>=20
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
>  app/test-flow-perf/actions_gen.c | 172 +++++++++++++
>  app/test-flow-perf/actions_gen.h |   4 +
>  app/test-flow-perf/async_flow.c  | 239 ++++++++++++++++++
>  app/test-flow-perf/async_flow.h  |  41 ++++
>  app/test-flow-perf/items_gen.c   |  13 +
>  app/test-flow-perf/items_gen.h   |   4 +
>  app/test-flow-perf/main.c        | 410 ++++++++++++++++++++++++-------
>  app/test-flow-perf/meson.build   |   1 +
>  8 files changed, 798 insertions(+), 86 deletions(-)
>  create mode 100644 app/test-flow-perf/async_flow.c
>  create mode 100644 app/test-flow-perf/async_flow.h


Looked good to me, but AI more detailed dive found some things:

The one thing it found was:

Race condition on `flow` variable =E2=80=94 insert_flows_async() is called
concurrently from multiple cores but uses a file-scope static `flow`
pointer. One core can overwrite it between async_generate_flow() and
the flows_list assignment. Needs a local `struct rte_flow *flow;`
declaration.

But lots more stuff that you should address:

# Review: [PATCH] test/flow: add support for async API

**Patch**: test/flow: add support for async API
**Author**: Maxime Peim <maxime.peim@gmail.com>
**Files changed**: 8 (798 insertions, 86 deletions)

---

## Errors

### 1. `alloca()` for `queue_attr_list` allocates wrong size (buffer overfl=
ow)

In `async_flow.c`, `async_flow_init_port()`:

```c
const struct rte_flow_queue_attr **queue_attr_list =3D
    alloca(sizeof(struct rte_flow_queue_attr) * nb_queues);
```

This allocates `nb_queues * sizeof(struct rte_flow_queue_attr)` bytes, but =
`queue_attr_list` is an array of **pointers** (`const struct rte_flow_queue=
_attr **`). It should allocate `nb_queues * sizeof(struct rte_flow_queue_at=
tr *)`. If `sizeof(struct rte_flow_queue_attr) < sizeof(pointer)`, this is =
a buffer overflow when iterating `nb_queues` entries. If `sizeof(struct rte=
_flow_queue_attr) > sizeof(pointer)`, it wastes stack space but is not dang=
erous.

**Fix**:
```c
const struct rte_flow_queue_attr **queue_attr_list =3D
    alloca(sizeof(struct rte_flow_queue_attr *) * nb_queues);
```

Or more idiomatically: `alloca(sizeof(*queue_attr_list) * nb_queues)`.

### 2. `alloca()` with unbounded `nb_queues` =E2=80=94 potential stack over=
flow

`nb_queues` comes from `mc_pool.cores_count` which is user-controlled via `=
--cores`. While it's capped by `port_info.max_nb_queues` if the device repo=
rts it, if `max_nb_queues` is 0 or `UINT32_MAX` (which the code explicitly =
skips), there's no upper bound enforced before `alloca()`. A large value co=
uld blow the stack.

**Fix**: Add a reasonable upper bound check before the `alloca()` calls, or=
 use `rte_malloc`/`malloc` instead.

### 3. `flow` variable used in `insert_flows_async()` without declaration

The function `insert_flows_async()` in `main.c` references `flow` (e.g., li=
ne 994: `flow =3D generate_flow(...)`, line 1014: `flow =3D async_generate_=
flow(...)`) but `flow` is never declared as a local variable within this fu=
nction. It appears to rely on a file-scope `static struct rte_flow *flow` v=
ariable. This creates a hidden data race: if multiple cores call `insert_fl=
ows_async()` concurrently (which they do =E2=80=94 `flows_handler` is calle=
d per-core), they share the same `flow` pointer without synchronization. On=
e core could overwrite `flow` between the `async_generate_flow()` call and =
the `flows_list[flow_index++] =3D flow` assignment.

**Fix**: Declare `struct rte_flow *flow;` as a local variable inside `inser=
t_flows_async()`.

### 4. Missing NULL check on `flow` before measuring first-flow latency

In `insert_flows_async()`:

```c
flow =3D async_generate_flow(...);

if (counter =3D=3D start_counter) {
    first_flow_latency =3D ...;
    printf(":: First Flow Latency ...\n");
}

if (force_quit)
    break;

if (!flow) {
    print_flow_error(error);
    rte_exit(EXIT_FAILURE, ...);
}
```

The `flow =3D=3D NULL` check happens **after** the first-flow latency measu=
rement and the `force_quit` check. If the first flow creation fails (`flow =
=3D=3D NULL`) and `force_quit` is set, the code breaks out of the loop and =
proceeds to use `flows_list` which has a NULL entry at index 0, potentially=
 causing issues during cleanup. More critically, if it's the first flow and=
 it fails, the code prints a misleading "First Flow installed" latency mess=
age before discovering the failure.

**Fix**: Move the `if (!flow)` check immediately after `async_generate_flow=
()`, before the latency print.

### 5. `port_attr.nb_counters` not set =E2=80=94 may cause configure failure

In `async_flow_init_port()`, `port_attr` is zero-initialized but `nb_counte=
rs` and `nb_aging_objects` are not set even though the flow actions may inc=
lude `COUNT` or metering. Some PMDs require these to be nonzero when counte=
rs are used with async flows. This could cause silent failures or `rte_flow=
_configure` to reject the configuration.

This is a moderate-confidence concern (~60%) =E2=80=94 it depends on the sp=
ecific PMD, but the code doesn't attempt to set these fields at all.

### 6. `#include "rte_common.h"` =E2=80=94 incorrect include style

In `main.c`:
```c
#include "rte_common.h"
```

DPDK public headers should be included with angle brackets: `#include <rte_=
common.h>`. Using quotes searches the local directory first, which is incor=
rect for a system/library header. This could also fail to compile if the lo=
cal directory doesn't have a copy.

---

## Warnings

### 7. `memset` on `set_ipv6_mask` inside function body with `static` varia=
ble

In `fill_actions_template()`:
```c
static struct rte_flow_action_set_ipv6 set_ipv6_mask;
/* ... */
memset(set_ipv6_mask.ipv6_addr.a, 0xff, 16);
```

The `memset` is called **every time** `fill_actions_template()` is invoked,=
 but the variable is `static`. This is redundant after the first call and s=
uggests the initialization should either be done once (with a static flag o=
r at file scope) or the variable shouldn't be `static`. It's not a bug, but=
 it's wasteful and indicates a design inconsistency =E2=80=94 all other sta=
tic mask variables are initialized at declaration.

### 8. `actions_counter` is `uint8_t` =E2=80=94 can overflow with many acti=
ons

In `fill_actions_template()`, `actions_counter` is declared as `uint8_t`, w=
hich limits it to 255 entries. While `MAX_ACTIONS_NUM` is likely smaller, t=
here's no bounds check against the `actions[]` and `masks[]` array sizes. I=
f the template_actions table plus the END sentinel exceeds the caller's arr=
ay, this silently writes out of bounds.

### 9. Unnecessary `rte_zmalloc` for `results` array in `insert_flows_async=
()`

```c
results =3D rte_zmalloc("results", sizeof(struct rte_flow_op_result) * asyn=
c_push_batch, 0);
```

Per AGENTS.md guidelines, `rte_malloc` is for DMA-accessible or shared memo=
ry. The `results` array is only used locally by the CPU for pulling flow op=
eration results. Standard `malloc` (or even a stack allocation if `async_pu=
sh_batch` is bounded) would be more appropriate and wouldn't consume limite=
d hugepage memory.

### 10. Gratuitous reformatting of the `lgopts[]` table

The patch reformats the entire existing `lgopts[]` table from `{ "name", ..=
.}` with alignment spaces to `{"name", ...}` without alignment. This change=
s 60+ lines that have nothing to do with the async feature, making the diff=
 much harder to review and potentially causing merge conflicts with other i=
n-flight patches.

This should be a separate cleanup patch, or the new entries should match th=
e existing style.

### 11. `rte_zmalloc` for `flows_list` =E2=80=94 unnecessary hugepage usage

```c
flows_list =3D rte_zmalloc("flows_list",
    (sizeof(struct rte_flow *) * (rules_count_per_core + 1)), 0);
```

This is a pointer array used only for bookkeeping. Standard `calloc` is app=
ropriate here. (Note: the existing `insert_flows()` has the same pattern, s=
o this may be intentional consistency, but it's still worth noting.)

### 12. Division by zero if `cpu_time_used` is zero

In `insert_flows_async()`:
```c
insertion_rate =3D ((double)(rules_count_per_core / cpu_time_used) / 1000);
```

If the loop completes very quickly or `rules_count_per_core` is 0, `cpu_tim=
e_used` could be 0, causing a floating-point division by zero (infinity/NaN=
). Additionally, the integer division `rules_count_per_core / cpu_time_used=
` truncates =E2=80=94 it should be `(double)rules_count_per_core / cpu_time=
_used` to get an accurate rate.

### 13. Commit message body line length

The commit body line `"Encapped data is fixed with pattern: ether,ipv4,udp,=
vxlan"` in the usage() help text additions (within the code) is fine, but t=
he actual commit message body should be checked =E2=80=94 the `--async-queu=
e-size=3DN:` line formatting appears tight but within limits.

### 14. Copyright uses "Mellanox Technologies" =E2=80=94 potentially outdat=
ed

The new file `async_flow.c` and `async_flow.h` use `Copyright 2026 Mellanox=
 Technologies, Ltd`. The author's email is `@gmail.com` (individual), and M=
ellanox was acquired by NVIDIA in 2020. This is noted only as an observatio=
n per AGENTS.md =E2=80=94 the copyright holder's choice is not subject to r=
eview.

---

## Summary

The most critical finding is **#3** =E2=80=94 the `flow` variable race cond=
ition in the multi-core `insert_flows_async()` path. If multiple cores run =
this function concurrently (which is the intended use), they would share an=
d clobber a file-scope `flow` pointer. This is a real correctness bug that =
would cause intermittent failures.

The **#1** `alloca()` size mismatch is also a clear bug that could cause me=
mory corruption depending on the struct size vs pointer size relationship o=
n the target architecture.

The remaining issues range from stack safety (#2), error handling order (#4=
), to style/efficiency concerns (#7=E2=80=93#12).
