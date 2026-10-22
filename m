Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436C606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=F//PMRVa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22BA440264;
	Thu, 22 Oct 2026 18:18:02 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 207CB4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:18:01 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so7871a91.2
 for <dev@dpdk.org>; Thu, 22 Oct 2026 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792685880;
 x=1793290680; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CibvLLlpbFIwPKztjPUNrc99KGparXJO2Q+Cug9TB7E=;
 b=F//PMRVa1Pkw8puVEeFC3OxK70cxEZW+lJccy9q8qcQAFetBYeHtja5GTrrIRQpp+W
 kapzJgKfo2k8Kj++D4/yE0/dOZsVhtCQaHVj4asgEAsslx7vRRrpSmJiOS0DvMl5eEer
 vg+wiM4i9HakKBiKdcVXVq9Gb+WgYaqBD4SvVid3//JLpSKfaZmt6QBpMNv50rzUy06L
 PSflHFm3C/m1tNpCe0kjTO6zRQWLOuUY32dlQm61VOQs6ey5roUHKyghj8iiLZ+ieRPU
 bFUPQsOpcI04Po/mpwGMgCe7fgeISnEqH/AOXPhohD3gvrvDFP1fOkkWjI9sAZTR+HWQ
 gjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792685880; x=1793290680;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CibvLLlpbFIwPKztjPUNrc99KGparXJO2Q+Cug9TB7E=;
 b=q5ocyAzrsq3ikZHO3SO46tmTuFQzDwUvC7vf9flUOBo15iLHflFbS9fT3vlTZx6Yzz
 pqiMn4HHJn0679G1IK+We/kzDrvAn3AY/ILQG/cXQb+MeLki5lsnsTD6C7sCtEyxKDR1
 aB7WEQi7pR7wmyGjJ4n8YMBsG765gEWP12zHp5ijSkKXIlM8ZSRt7yvwG2odLhmEgqvw
 vTd48jxljzdT35hIbMRFYeBDvK6z1Kw9iO4SAgo6DwpB8AYkCM5SlYt2ypDDZPR1X5aC
 FS7GDrqlK/aDcpBZf1JDH36V6Zvoa4X8VaZN+Rm3JilDi2ekvT5OBQvSHEyKKma2BD1/
 zfeg==
X-Gm-Message-State: AFq9FYK9XdCu1ja500sUR7lpeeBro77/Drw6X7BErGyfhYCSsw0fqCKb
 EQL1lIkJKJ+iwQRDbPro8F9E1ar2REYiaXXX8ZbqBN5PtookKohNW3o68Lxc17zWwEerhGJaZDe
 wAMrXziw=
X-Gm-Gg: AYBFou2/DQEuyYAy6msXL3uEtcufvUGp1Sipgw2Dj1S69PrjqyUe2+44jHNntsL3x9u
 ut1XPDo5dp5h31yOgaVmPIir4fYxCPZla3RTMyLVDXeHBl+jW0Tbi61HRkGP+pMz9EmnwQByvtD
 Xnp//X4juzuLerv25m7Xo20vTi1u12Dmg36Z74nMvKyjG5uGy8KoP+4sXQyMNOuunqR0N8KLfUa
 3gqga8nz2E803tjr3IjO7vIuJN2iUd/AHtQbmtmEwC8/TinYa7WB5JmuvHsp9OBZHsshxI68atV
 en+u8fVctn8z9//blaPdmGNsogKtTEGjVAhwLEQUp8gxTIcG7wZAmh9LgsUWidhfqx9TGIJfl5N
 UcAz72Nzre8FRfiQeMFNw9iEwbRkkUWYUylzfjS1FARQ7Cfn33VmG/Ebh2yARZsxcP71rV9RoMM
 OraALLWmfQdB9tD8gxZ4fEN7ODV2aPeXytVOvxE378TlR3y9J7ehiKmyoRKjSLAXlXFY7ynCAfV
 TS7HLDwyb1n7AA58vBCDVe/IBEwOjxgMXsmW/9vq9UZn8cYPuzbdKoYnQOjwKnNjnw8XsYUTT/q
 PqEtD/DS+A3tb5Hz+nAPUrinYivfLAZktMtNl3s3J/Y=
X-Received: by 2002:a17:90b:55cf:b0:3ad:6ec8:35cf with SMTP id
 98e67ed59e1d1-3ad86cc1ca5mr4112021a91.51.1792685879808; 
 Thu, 22 Oct 2026 09:17:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6b80528e9sm1600225a12.1.2026.10.22.09.17.59
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:17:59 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:17:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: RFC - redesign primary/secondary connection
Message-ID: <20261022091756.1b391552@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The recent bug 2069 made me look in more detail at primary/secondary design.
It is a mess now, and not fixable for 26.11. Do not infer that this
will get done, but sending out a trial balloon for discussion.

The draft AI guided design I came up with is to have a more direct connection
between primary and secondary.

Subject: [RFC] eal: connected control channel for multi-process

The primary process has no session with its secondaries, so it cannot
make them stop before it frees shared state. The mp channel is
connectionless datagram sockets found by scanning a directory.
Membership is inferred from socket files, liveness is guessed, and the
primary's only lever is a best-effort message to a thread it cannot
see.

Bug 2069 is one visible symptom. Stopping the primary symmetric_mp
makes the secondary segfault, because rte_eal_cleanup() in the primary
closes ports and shrinks the heap before MP_REQ_QUIT is sent. Nothing
proposed for 26.11; this is for 27.03 or later.

Multi-process is Linux only today. It was never implemented on
FreeBSD, and Windows is missing several pieces, so this proposal uses
Linux mechanisms freely.


Problems with the current model
-------------------------------

1. No membership. The primary does not know which secondaries exist.
   Broadcast scans /run/dpdk/<prefix>/mp_socket_*, and stale files
   from dead processes look like peers until a send fails.

2. No liveness either way. The primary cannot see a secondary die.
   The secondary only learns the primary died by polling the config
   file lock (rte_eal_primary_proc_alive()), which is held until the
   very end of the primary's exit.

3. No ordered shutdown. QUIT is fire-and-forget, sent after teardown,
   with no ack.

4. No quiesce point for the datapath. EAL cannot make an application
   stop touching a shared object before the primary frees it. The
   same hole exists for hotplug detach and port reconfigure, not just
   exit.

5. Undefined secondary cleanup. Secondary cleanup runs PMD close and
   uninit as if it owned the device, and relies on every driver
   early-returning.


Proposal
--------

1. Connected control channel

   - The primary listens on one SOCK_SEQPACKET unix socket. Each
     secondary connects during rte_eal_init() and holds the
     connection for its lifetime.
   - The connection is the membership. The kernel reports peer death
     as EOF/POLLHUP on both sides, including SIGKILL and crashes. No
     stale files, no directory scan.
   - SEQPACKET keeps message boundaries, delivers in order, and
     carries SCM_RIGHTS, so vfio and memfd fd passing keep working.
   - SO_PEERCRED gives the peer pid. On Linux, SO_PEERPIDFD (6.5+) or
     pidfd_open() gives a race-free handle, so the primary can signal
     a wedged secondary whose mp thread no longer responds.
   - rte_mp_* keeps its API; broadcast becomes "iterate connections".
     Primary and secondary must already be the same build, so there
     is no wire compatibility concern.

2. Membership and admission

   - The primary keeps a secondary table in private memory:
     connection, pid, state (ATTACHING, RUNNING, QUIESCING, DETACHED).
   - The primary has its own state, RUNNING or SHUTTING_DOWN. Once
     shutdown starts, new connections are refused, closing the late
     joiner race.
   - Application API: a count or iterator of attached secondaries,
     and attach/detach callbacks so a primary can react (for example
     reassigning queues the way symmetric_mp splits them by proc-id).

3. Two-phase shutdown

   1. The primary enters SHUTTING_DOWN and stops admitting.
   2. It sends QUIESCE on each connection.
   3. The secondary EAL delivers it to the application. A registered
      callback stops the lcores and returns; with no callback, the
      default is raise(SIGTERM), which keeps existing apps working.
   4. The secondary replies QUIESCED, detaches and closes the
      connection.
   5. The primary waits for EOF on every connection. EOF means the
      secondary is gone, not just that it received the message.
   6. On timeout, policy decides: leave shared state and exit (leak),
      or kill stragglers and tear down. Both an EAL option with a
      sane default.
   7. Only then does the primary run service, bus and memory
      teardown.

     Primary EAL          Secondary EAL          Secondary app
          |                     |                      |
          |--- QUIESCE -------->|                      |
          |                     |-- callback/SIGTERM ->|
          |                     |                  lcores stop
          |                     |<----- returned ------|
          |<-- QUIESCED --------|                      |
          |<-- EOF (close) -----|                      |
          |                     |                      |
      teardown (or on timeout: leak, or kill stragglers)

   EOF on the connection, not the QUIESCED reply, is what releases
   the primary to tear down.

4. Primary death

   - The secondary sees EOF on the control connection immediately,
     whatever killed the primary.
   - EAL marks itself orphaned. mp requests fail fast with EPIPE
     instead of timing out. The same callback or SIGTERM default
     fires, without an ack.
   - The secondary keeps its hugepage mappings and fds, so nothing
     faults while it exits.
   - rte_eal_primary_proc_alive() becomes a state check, and
     testpmd's monitor_primary() goes away.

5. Quiesce beyond shutdown

   The same request, callback and ack pattern covers the other cases
   where the primary frees objects a secondary uses:

   - Device detach. eal_dev_hotplug_request_to_secondary() detaches
     in the secondary today without stopping its datapath. It should
     go through the application callback first.
   - Port stop and reconfigure while a secondary is forwarding.
   - Event forwarding. The primary forwards LSC and RMV ethdev events
     over the channel, which removes the documented "interrupts don't
     work in secondary processes" limitation as a side effect.

6. Secondary cleanup semantics

   - A secondary releases only what it created: its own vdevs and
     ports, its own shared allocations, its fds and mappings. It does
     not call PMD close or uninit for devices it only attached to;
     process exit reclaims per-process state.
   - To make that possible, record a creator process id on ethdev
     ports, and possibly on memzones. When a connection drops without
     a clean detach, the primary reclaims what that secondary created,
     so a crashed secondary no longer leaves zombie ports in shared
     data.


Phasing
-------

Phases 1 to 3 fix bug 2069 properly. Phases 4 and 5 are where the
design becomes strong, and are the larger API discussion.

1. Connected channel under the existing rte_mp_* API, plus EOF
   detection on both sides.
2. Membership table, admission control, primary death handling in the
   secondary.
3. Shutdown protocol with application callback and SIGTERM default;
   reorder rte_eal_cleanup().
4. Quiesce for hotplug and port reconfigure; ethdev event forwarding.
5. Creator tracking and reclaim of resources from dead secondaries.


Alternatives considered
-----------------------

- pidfd only. Gives liveness and signalling, but no ordered messaging
  and no ack. Better as an addition to the connected channel than as
  its base.

- Shared memory refcounts on ports and queues. Needs the datapath to
  take references, which costs fast path cycles and still needs a
  wakeup mechanism. Quiescing over the control channel leaves the
  fast path untouched.


Comments welcome, especially from anyone with production
multi-process deployments, on the shutdown policy default and on
whether SIGTERM as the fallback is acceptable.
