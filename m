Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0CC9EC6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 11:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF4540A6C;
	Mon, 12 Jan 2026 12:01:26 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9232840288
 for <dev@dpdk.org>; Mon, 12 Jan 2026 12:01:25 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B8C74206E5;
 Mon, 12 Jan 2026 12:01:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 1/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Mon, 12 Jan 2026 12:01:21 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65652@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aWS7YdU11DNPbz4o@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Thread-Index: AdyDo9eUt8LxvB60SiuECJt9Se1XPwADjYEA
References: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
 <20260111150033.81760-2-scott.k.mitch1@gmail.com>
 <20260111075919.082d12b2@phoenix.local>
 <aWS7YdU11DNPbz4o@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <scott.k.mitch1@gmail.com>,
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Monday, 12 January 2026 10.14
>=20
> On Sun, Jan 11, 2026 at 07:59:19AM -0800, Stephen Hemminger wrote:
> > On Sun, 11 Jan 2026 10:00:32 -0500
> > scott.k.mitch1@gmail.com wrote:
> >
> > > +#define RTE_PTR_ADD(ptr, x) \
> > > +	(__extension__ ({ \
> > > +		/* Diagnostics suppressed for internal macro operations
> only. \
> > > +		 * Compiler type-checks all _Generic branches even when
> unselected, \
> > > +		 * triggering warnings with no external impact. */ \
> > > +		__rte_diagnostic_push \
> > > +		__rte_diagnostic_ignored_wcast_qual \
> > > +		_Pragma("GCC diagnostic ignored \"-Wconditional-type-
> mismatch\"") \
> > > +		/* Uses uintptr_t arithmetic for integer types (API
> compatibility), \
> > > +		 * and char* arithmetic for pointer types (enables
> optimization). */ \
> > > +		__auto_type _ptr_result =3D _Generic((ptr), \
> > > +			unsigned long long: ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			long long:          ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			unsigned long:      ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			long:               ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			unsigned int:       ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			int:                ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			unsigned short:     ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			short:              ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			unsigned char:      ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			signed char:        ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			char:               ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			_Bool:              ((void *)((uintptr_t)(ptr) +
> (x))), \
> > > +			/* Ternary with null pointer constant: per C11, if
> one operand \
> > > +			 * is a null pointer constant and the other is a
> pointer, the \
> > > +			 * result type is qualified per the pointer operand,
> normalizing \
> > > +			 * const T* to const void* and T* to void*. */ \
> > > +			default: _Generic((1 ? (ptr) : (void *)0), \
> > > +				const void *: ((void *)((const char *)(ptr) +
> (x))), \
> > > +				default:      ((void *)((char *)(ptr) + (x))) \
> > > +			) \
> > > +		); \
> > > +		__rte_diagnostic_pop \
> > > +		_ptr_result; \
> > > +	}))
> >
> > Good idea in general but the macro is way to big and therefore hard
> to read.
> > The comments could be outside the macro.
> >
> > Any code that adds dependency on a pragma to work is brittle and
> likely
> > to allow bugs through. Please figure out how to do it without.
>=20
> Do we need to handle the case of users calling RTE_PTR_ADD with =
integer
> values? Using this macro to essentially cast an integer to pointer
> seems
> strange. Even if it's occasionally used, I think keeping things simple
> and
> just globally changing to use "char *" is a better approach.
>=20
> The only case where I'd consider trying to keep compatibility using
> uintptr_t is if the pointer parameter is a volatile one. Even then, we
> can
> probably handle that as with the "const" modifier, right?

None of the RTE_PTR_ macros can handle qualifiers (const, volatile).
Maybe it would be better to provide a new set of macros with a qualifier =
parameter, instead of adding new macros with e.g. _CONST in the names.

