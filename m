Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CCC369A1
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Apr 2025 11:07:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2727A402C4;
	Sat, 12 Apr 2025 13:06:59 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 79BA840285
 for <dev@dpdk.org>; Sat, 12 Apr 2025 13:06:58 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2F607207AC;
 Sat, 12 Apr 2025 13:06:58 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 00/13] Packet capture using port mirroring
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 12 Apr 2025 13:06:55 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FBC9@smartserver.smartshare.dk>
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 00/13] Packet capture using port mirroring
Thread-Index: AdurPHDIwmjWSNbrR7i4rWhg2RbTigAVUb1A
References: <20250411234927.114568-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Saturday, 12 April 2025 01.45
>=20
> This is a rework of how packet capture is done in DPDK.
> The existing mechanism using callbacks has a number of problems;
> the main one is that any packets sent/received in a secondary process
> are not visible. The root cause is that callbacks can not function
> across process boundaries, they are specific to the role.
>=20
> The new mechanism builds on the concept of port mirroring used
> in Linux/FreeBSD and also router vendors (SPAN ports). The
> infrastructure
> is built around a new ethdev call to mirror a port.
>=20
> The internals of dumpcap are redone but the program command
> syntax is unchanged (no doc change needed). Usingthe new mirror
> mechanism,
> the dumpcap program creates a port using ring PMD and
> then directs mirror to that. Then the packets are extracted from the
> ring.
> If capturing on multiple devices, they all get mirrored to
> the same ring PMD.

Here's some general feedback...

I very much like the concept of using a shared ring for carrying the =
mirrored packets.
It allows other types of future consumers to process the mirrored =
packets, e.g. encapsulating and forwarding them into an L2 or L3 tunnel, =
or Wireshark remote capture.

Using a Ring PMD instead of setting up a dedicated ring also has some =
advantages, such as the ability to set up multiple separate mirror =
target instances.
For performance reasons, we should ensure that a lightweight Ring PMD is =
available for mirroring, in case the Ring PMD is extended with new =
features affecting its performance.
Or maybe create a new type of mirror/capture virtual PMD. This would =
allow applications to enqueue packets from non-ethdev interfaces into =
it.

I'm not convinced you should undo the VLAN offloads when enqueueing a =
mirror packet... If you do, you should also undo QinQ offloads. Undoing =
offloads is never going to end.
And if you create a dedicated PMD type for carrying mirrored packets, =
you can ensure that the offload fields remain intact on dequeue.

You should consider sampling and VLAN filtering as typical mirroring =
features.
It would improve the performance if such filtering is done before =
copying the packets.

PS: I agree with your choice of copying (rather than cloning by =
refcount) when mirroring the packets.

>=20
> Doing this uncovered a bunch of additional missing features and bugs.
> The first is that test-pmd auto attach introduced in 24.11 breaks this
> (and it broke old pdump as well) so it is removed.
>=20
> The dumpcap program needs to be able to start the ring PMD it created
> but the existing ethdev API is broken when used from secondary =
process.
> So fix that.
>=20
> The mirror API has a restriction that the port being mirrored to must
> allow
> lock free transmit. This is because both rx and tx as well as multiple
> queues need to go over the same transmit queue. Although it might be
> possible
> to have some complex mapping between multiple ports/queues being
> mirrored
> to multiple transmit queues, that gets to be a lot of overhead in =
API's
> and implementation. Fixing the ring and null PMD to allow lockeless
> transmit is good enough.
>=20
> Added tests for the new features.
> The performance has not been measured but the overhead of checking for
> mirror port is no more that the overhead of looking at the callback
> list.
>=20
> TODO items:
>   - need release notes for new features
>   - more through testing on real hardware
>   - mark old pdump API and application for deprecation in 25.07 and
> removal in 25.11
>   - more cleanup of patch wording and docs needed.


