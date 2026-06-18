Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8963CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 16:45:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9939A402B6;
	Thu, 18 Jun 2026 18:45:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2F94F4028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 18:45:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0BDFA201E4;
 Thu, 18 Jun 2026 18:45:22 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 1/1] pcapng: add user-supplied timestamp support
Date: Thu, 18 Jun 2026 18:45:19 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65924@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260618082240.517e60cb@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/1] pcapng: add user-supplied timestamp support
Thread-Index: Adz/NlMyx9iBOoBeTFe47DIDkf9IfgABuEzw
References: <20260618143819.310046-1-dawid.wesierski@intel.com>
 <20260618082240.517e60cb@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Dawid Wesierski" <dawid.wesierski@intel.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>,
 "Marek Kasiewicz" <marek.kasiewicz@intel.com>
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
> Sent: Thursday, 18 June 2026 17.23
>=20
> On Thu, 18 Jun 2026 10:38:15 -0400
> Dawid Wesierski <dawid.wesierski@intel.com> wrote:
>=20
> > + * @param ts
> > + *   Packet timestamp in nanoseconds since the Unix epoch. If zero,
> the
> > + *   current TSC is captured and converted to epoch ns by
> > + *   rte_pcapng_write_packets() when the packet is written.
> >   *
>=20
> It might help users if a helper rte_tsc_to_epoch() was exposed.

+1

Please note that such a helper would need to compensate for rte_rdtsc() =
drift.

Simplified:

int64_t rte_tsc_to_ns(tsc)
{
  struct timespec ts =3D clock_gettime(CLOCK_REALTIME);
  int64_t now_ns =3D ts.tv_sec * NS_PER_S + ts.tv_nsec;
  int64_t now_tsc =3D rte_rdtsc();
  int64_t diff_tsc =3D tsc - tsc_now;
  return now_ns + diff_tsc * NS_PER_S / rte_get_tsc_hz();
}

A performance optimized version would take "now_ns" and "now_tsc" as =
parameters.
And with "now_ns" passed as a parameter, the function also works with =
other clocks, such as CLOCK_MONOTONIC.

Also see this discussion on the Grout mailing list:
https://inbox.dpdk.org/grout/98CBD80474FA8B44BF855DF32C47DC35F6590E@smart=
server.smartshare.dk/T/#m465a04ca2e8219612dd9c3efb4198d23d5813422


