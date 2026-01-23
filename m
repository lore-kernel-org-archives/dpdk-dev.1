Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A63D6CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 06:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9625C4021F;
	Fri, 23 Jan 2026 07:08:18 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 362DC400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 07:08:17 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo20771765e9.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769148497;
 x=1769753297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B74eIdxLkzj2cgtU6o5HKqPutaFfWdxBEQkF+VHNXp4=;
 b=d7hgK7tqLiKbKMxwuZx8VJPHKyetIXi5IBYEa4Z5L6Bd9x4ttqDFuyk5CHgm9IhK9N
 jrVbl3ntENCyGus5fO+6+C0tijGJ6NuQzALYchm/uzmMkP1dah4Jh8xl5nhdw6CB4Dk8
 bJSUqiyUB0CdH65Q2gqezF/lDCV193WJGdHsFtWRnwRu6eIjqUk7ommLbI2ByqVYkq3u
 cNF4gpUu9F3XNF9VqNDG/HBH36bJCUO+aHxkNUJAEofgnqneDjuc0syT09OrDTCKYYty
 tYJsQvbY1Y/98Jp8IPhVu7goxUel0T4sHAV97gdLkkl3i8wT2LSEdOm1KNZUWpuF4MEm
 AL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769148497; x=1769753297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B74eIdxLkzj2cgtU6o5HKqPutaFfWdxBEQkF+VHNXp4=;
 b=qpZ3eARqDciTD0rdRnUGiiEIr70qPCCFQ6DHuXDvashMDylsutNaooehXAqgc5Gsrf
 a5Ux9Bds2D+CtiV2XVuwTGOTKbu+2FsesiewwfkFCdOvjf15aJ9/T7HVTIKdNHT+mX+P
 ypqZgLEBcjH9PRQtZnToTNkX3QKxaUe/M4qHrI92JVWoCmgaUw0+SnRyIiwJ1jVWEJHZ
 Da8/F0+8i5mf9r754/g2NHKt37X7mrO4dqkNx5woP/uH3fm0PFSph1fyl3A4IRnTNITH
 eOfkSJvjaPFhqVOb3PV7cr1Q1rvt9yv0ZJ26w0su+wS4902irN2/dlk4q+igC6sw5hh0
 O88g==
X-Gm-Message-State: AOJu0Ywjp93v6lyt9riPhFj/cMF5YiR+H8pwaOuS/KMqFj7GPj39PNeH
 5/Jb0WNQWJ5CDDw6K4eIjOer0O0vbGaA8Zn5hOU5onRkfE4kSQ2TVjSGfYYeJHAxLyA=
X-Gm-Gg: AZuq6aKCYiy40vVXqJkg+6mVH1RDoCBnJhZ6cULSEonCsAmZAg/PqL1yxEAEFNBjeK/
 7f0UoFBV+Hdk4KCsmO+DHNsPP7hqBMUKpUciVTvI0s07N2aB4dhnN8xtVh6g+/oCqF3YzCPNNlJ
 DDQJfPQXnJW2geJwLZ+dfEkSOLmlMYmeby3iBLbqgEZgO4QoFBK7wwbiyDGhcv4/hmgesC7OXR8
 scwA/Dz5eedsFr9+hYUCGJSc9bzjGUFyAfn8wC156CDnFNX0X+gXkOa3cyixkaMPJXToFs9mCJC
 kiATqGh7mZKI9rUsWfwII3b+5h8t3upPB/Tb7XoX4Beth3WDqb2UjGeobzMCZriMx+sXdVaiX3W
 LNY/h1be8uGrdmi7VfEwWw7sQwIFzP0Kta8Jzjh8yHMoG9kWYuQ08YRDcfptWjAHQTot+JHcgD1
 payAui04qqWYSHVRixrnCLH7opk/AgvUq575jCMYiQWvb1vTByf1KbTOkCnaB1fqk=
X-Received: by 2002:a05:600c:8b6e:b0:480:462e:d640 with SMTP id
 5b1f17b1804b1-4804c9cfef1mr30537125e9.36.1769148496575; 
 Thu, 22 Jan 2026 22:08:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745e6sm3989328f8f.33.2026.01.22.22.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 22:08:16 -0800 (PST)
Date: Thu, 22 Jan 2026 22:08:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Mattias
 =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>, "Maria Lingemark"
 <maria.lingemark@ericsson.com>, Luka Jankovic <luka.jankovic@ericsson.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: Re: [RFC 0/4] Add support for event credit preallocation
Message-ID: <20260122220810.2a9b67dd@phoenix.local>
In-Reply-To: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
References: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
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

On Sun, 29 Jun 2025 18:52:10 +0200
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> Events of type RTE_EVENT_OP_NEW are often generated as a result of
> some stimuli from the world outside the event machine. Examples of
> such input can be a timeout in an application-managed timer wheel, a
> control plane message on a lockless ring, an incoming packet
> triggering the release of buffered packets, or a descriptor arriving
> on some hardware queue.
>=20
> In non-event-triggered cases, the external-trigger-to-eventdev-event
> mechanism serves the same role as various Eventdev adapters, but for
> input that does not have native Eventdev support.
>=20
> The actual RTE_EVENT_OP_NEW event enqueue is often preceded by a
> processing. Such processing may be both expensive or effectively
> irreversible. In addition, in case the enqueue is likely to fail,
> there is not even a point in polling the external source for new
> input.
>=20
> In such a scenario, efficiency could potentially be improved and code
> complexity reduced in case the application could know ahead of time,
> with some certainty, that the enqueue operation will succeed.
>=20
> Event devices have a mechanism that puts an upper bound to the number
> of in-flight (buffered) events. In many cases (e.g., DLB, DSW, and SW)
> there is a credit system putting an upper bound on the number of
> in-flight events. A new event consumes a credit, which is returned
> to the credit pool when the event is released. In the current
> Eventdev API, all this happens "under the hood" and is not visible
> to the application.
>=20
> This patchset optionally splits the enqueue operation into two steps:
> 1) rte_event_credit_alloc() to allocate "slots" for the events, in the
>    form of credits. One credit grants the application the right to
>    enqueue one event of the type RTE_EVENT_OP_NEW_PREALLOCED.
> 2) The actual enqueue operation, with the rte_event.op set to
>    RTE_EVENT_OP_NEW_PREALLOCED.
>=20
> The new operation type RTE_EVENT_OP_NEW_PREALLOCED is identical to
> RTE_EVENT_OP_NEW, with the only exception that credit allocation
> (either conceptually or literally) has already been successfully
> completed.
>=20
> Whether or not a credit allocation will succeed depends on the
> new_event_threshold of the request. In the current Eventdev API,
> new_event_threshold is strictly a port-level configuration. Beyond
> simply allocating a credit, this patchset also address flexibility in
> terms of making the new_event_threshold a per-allocation property.
>=20
> Control over new_event_threshold is very important to tune system
> behavior at overload.
>=20
> In the general case, failure to allocate a credit is only one reason
> an enqueue operation may fail. API semantics-wise, the possession of a
> credit does not guarantee that the subsequent enqueue operation will
> succeed. Certain event device implementations may come with stronger
> guarantees.
>=20
> In case the application decides not to (or fails to) spend its credits
> enqueuing RTE_EVENT_OP_NEW_PREALLOCED events, it may return them using
> the new rte_event_credit_free() function.
>=20
> For performance and API consistency reasons, a new preallocation-optimized
> enqueue function rte_event_enqueue_prealloced_burst() is added.
>=20
> To allow the application to query if the credit management and the new
> enqueue function are available on a particular event device, a new
> capability RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION is added.
>=20
> Mattias R=C3=B6nnblom (4):
>   eventdev: add support for credit preallocation
>   event/dsw: add support for credit preallocation
>   eventdev: add enqueue optimized for prealloced events
>   event/dsw: implement enqueue optimized for prealloced events
>=20
>  drivers/event/dsw/dsw_evdev.c        |   6 +-
>  drivers/event/dsw/dsw_evdev.h        |   9 ++
>  drivers/event/dsw/dsw_event.c        |  86 ++++++++++--
>  drivers/event/dsw/dsw_xstats.c       |   3 +
>  lib/eventdev/eventdev_pmd.h          |   6 +
>  lib/eventdev/eventdev_private.c      |  24 ++++
>  lib/eventdev/eventdev_trace_points.c |   8 ++
>  lib/eventdev/rte_eventdev.h          | 193 +++++++++++++++++++++++++++
>  lib/eventdev/rte_eventdev_core.h     |  12 ++
>  lib/eventdev/rte_eventdev_trace_fp.h |  19 +++
>  10 files changed, 354 insertions(+), 12 deletions(-)
>=20

This didn't get any feedback. Likely because there aren't that many develop=
ers
actively looking at eventdev.

The AI patch review did see some issues that need to be addressed.
(And some false positives like your name).

=3D=3D=3D Patch Review: bundle-1684-event-credit.mbox (via Claude) =3D=3D=3D
# DPDK Patch Review: Event Credit Preallocation RFC Series

## Overview
This RFC series adds credit preallocation support to the eventdev subsystem=
, allowing applications to pre-reserve "slots" for new events before enqueu=
eing them. The series consists of 4 patches adding the API, DSW driver impl=
ementation, and optimized enqueue functions.

---

## Patch 1/4: eventdev: add support for credit preallocation

### Errors

1. **Missing `__rte_experimental` tag on new API functions**
   - `rte_event_credit_alloc()` and `rte_event_credit_free()` are new publi=
c API functions but lack the required `__rte_experimental` annotation.
   - Per guidelines: "New APIs must be marked as `__rte_experimental`"
   ```c
   // Should be:
   __rte_experimental
   static inline int
   rte_event_credit_alloc(uint8_t dev_id, uint8_t port_id, ...);
   ```

2. **Missing Signed-off-by with ASCII name**
   - The Signed-off-by line uses non-ASCII character: `Mattias R=C3=B6nnblo=
m`
   - This is acceptable per DPDK guidelines for author's actual name, but v=
erify the email is valid.

### Warnings

1. **Line exceeds 100 characters** (rte_eventdev_core.h:28)
   ```c
   typedef int (*event_credit_alloc_t)(void *port, unsigned int new_event_t=
hreshold, unsigned int num_credits);
   ```
   This line is ~107 characters. Should be wrapped.

2. **Trace point symbol naming inconsistency** (eventdev_trace_points.c)
   ```c
   RTE_EXPORT_SYMBOL(__rte_eventdev_credit_alloc)  // Missing _trace_ in na=
me
   RTE_EXPORT_SYMBOL(__rte_eventdev_credit_free)   // Missing _trace_ in na=
me
   ```
   Should be `__rte_eventdev_trace_credit_alloc` and `__rte_eventdev_trace_=
credit_free` to match the pattern used by other trace points in the file.

3. **Trace emits using wrong type for unsigned int parameters** (rte_eventd=
ev_trace_fp.h)
   ```c
   rte_trace_point_emit_int(new_event_threshold);
   rte_trace_point_emit_int(num_credits);
   ```
   These should use `rte_trace_point_emit_u32()` since the parameters are `=
unsigned int`.

4. **Missing documentation update**
   - New API capability `RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION` and new fu=
nctions need to be documented in the programmer's guide.
   - Release notes should be updated for this new feature.

5. **Missing testpmd hooks and functional tests**
   - Per guidelines: "New APIs must have hooks in `app/testpmd` and tests i=
n the functional test suite"

### Info

1. **Typo in documentation** (rte_eventdev.h)
   ```c
   * Besides using up credits by enqueuing @ref RTE_EVENT_OP_NEW_PREALLOCAD
   ```
   Should be `RTE_EVENT_OP_NEW_PREALLOCED` (fixed in patch 3, but inconsist=
ent).

2. **Consider using `RTE_EVENT_OP_NEW_PREALLOCED` value**
   ```c
   #define RTE_EVENT_OP_NEW_PREALLOCED     3
   ```
   This is defined after `RTE_EVENT_OP_FORWARD` (1) and `RTE_EVENT_OP_RELEA=
SE` (2), which maintains ordering, but value 3 appears between them in the =
header. Consider reordering definitions for clarity.

---

## Patch 2/4: event/dsw: add support for credit preallocation

### Errors

None.

### Warnings

1. **Potential integer overflow in credit counting**
   ```c
   port->new_prealloced_enqueued +=3D num_new_prealloced;
   ```
   The counter is `uint64_t` which should be fine, but there's no overflow =
protection.

2. **Missing documentation for new xstats counter**
   - `port_%u_new_prealloced_enqueued` is added but not documented.

### Info

1. **Good practice**: The implementation correctly reuses existing infrastr=
ucture and follows the DSW driver patterns.

---

## Patch 3/4: eventdev: add enqueue optimized for prealloced events

### Errors

1. **Missing `__rte_experimental` tag**
   - `rte_event_enqueue_new_prealloced_burst()` is a new API function but l=
acks `__rte_experimental`.

2. **Typo in documentation comment** (rte_eventdev.h)
   ```c
   n * @param port_id
   ```
   Should be:
   ```c
    * @param port_id
   ```
   There's an extra 'n' character at the beginning of the line.

### Warnings

1. **Inconsistent comment** (rte_eventdev_core.h:66-67)
   ```c
   event_enqueue_burst_t enqueue_new_prealloced_burst;
   /**< PMD enqueue burst new function. */
   ```
   Comment says "new function" but should say "new prealloced function" to =
distinguish from `enqueue_new_burst`.

2. **Missing dummy function initialization** (eventdev_private.c)
   - While `enqueue_new_prealloced_burst` is set in `event_dev_fp_ops_set()=
`, there's no corresponding dummy function initialization in `event_dev_fp_=
ops_reset()`.

### Info

1. **Documentation clarity**: The function documentation is good and follow=
s existing patterns.

---

## Patch 4/4: event/dsw: implement enqueue optimized for prealloced events

### Errors

None.

### Warnings

1. **Missing default `new_event_threshold` handling in main path**
   - In patch 2, `dsw_event_credit_alloc()` doesn't handle `new_event_thres=
hold =3D=3D 0` initially; this is only added in patch 4. This creates a com=
pile-time inconsistency between patches.
   - The check should be in patch 2 where `dsw_event_credit_alloc()` is int=
roduced:
   ```c
   if (new_event_threshold =3D=3D 0)
       new_event_threshold =3D source_port->new_event_threshold;
   ```

### Info

1. **Good practice**: The implementation follows existing DSW patterns and =
correctly reuses the generic enqueue function.

---

## General Issues Across All Patches

### Errors

1. **ABI/API symbols not exported**
   - New functions `rte_event_credit_alloc()`, `rte_event_credit_free()`, a=
nd `rte_event_enqueue_new_prealloced_burst()` are inline functions, but the=
 trace points need proper symbol versioning.

### Warnings

1. **Missing version.map updates**
   - If any non-inline functions are added, they need to be exported in `li=
b/eventdev/version.map`.

2. **No unit tests provided**
   - The series should include tests in `app/test/` for the new functionali=
ty.

3. **Release notes not updated**
   - Per guidelines: "Release notes updated for new drivers or subsystems" =
and "API changes require release notes".

4. **Commit message body formatting**
   - Patch 1 commit body is well-written but could benefit from mentioning =
this is an RFC with incomplete features (missing tests, docs).

### Info

1. **RFC Status**: As an RFC, missing tests and documentation are expected,=
 but they should be added before the series moves to non-RFC status.

2. **Capability flag placement**: `RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION (=
1ULL << 21)` - verify this doesn't conflict with any other capability flags.

---

## Summary

| Severity | Count |
|----------|-------|
| Error | 4 |
| Warning | 12 |
| Info | 6 |

**Key items to address before moving from RFC:**
1. Add `__rte_experimental` tags to all new API functions
2. Fix the line length violation in `rte_eventdev_core.h`
3. Fix the typo in patch 3 documentation (`n * @param`)
4. Fix trace point symbol naming
5. Add unit tests and testpmd hooks
6. Update release notes and programmer's guide
7. Fix trace emit types for unsigned parameters
